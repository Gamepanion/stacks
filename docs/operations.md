# Operating gamepanion.app

gamepanion.app is Gamepanion from `gamepanion/` of this repository, on `products-1` (Hetzner, with notefeed.me and gesetze-fuer-ki.de), checked out at `/srv/stacks/gamepanion/`. `MarcelBruckner-Business/ansible` deploys it: it writes `gamepanion/.env` from its vault, starts the containers, installs whisper's model, routes the name through Caddy on `gewerbe-1` (in `MarcelBruckner-Business/stacks`), sets the DNS records at Cloudflare to `gewerbe-1` (proxy off, Caddy's own certificates) and runs the backups. Its `docs/products-1.md` has the commands.

```mermaid
flowchart LR
  P["players, Claude"] -- "https://gamepanion.app" --> C["Caddy on gewerbe-1<br/>(MarcelBruckner-Business/stacks)"]
  C -- "private network, 10.0.0.3:8082" --> G["gamepanion<br/>data/*.sqlite"]
  G -- "http://whisper:8000" --> W["gamepanion-whisper<br/>whisper/ (model)"]
  G -. "SMTP" .-> M["Strato<br/>noreply@gamepanion.app"]
  G -. "Claude API" .-> A["Anthropic"]
```

## Settings

Every setting is in `gamepanion/.env`, written by the deployment from its vault; `.env.example` lists the names. Sign-in is by emailed code and link, then a passkey; no OpenID provider. `PUBLIC_URL` is `https://gamepanion.app`: passkeys are bound to it, and so is every connected Claude.

The imprint, privacy policy, terms and the subscribe page's words are the files in `gamepanion/legal/`, one per language (`imprint.en.md`, `imprint.de.md`, …), mounted read-only and named in `compose.yaml`. A change is a commit here and a deployment; the prices in `terms.*.md` must say what the Creem products say. With a payment provider set, Gamepanion does not report healthy without all four.

## Upgrading

A Dependabot pull request bumps the image in `compose.yaml`. Merge it, then deploy (`ansible-playbook site.yml --limit products-1`). The deployment takes a dump before it touches a changed checkout or `.env`; if that fails, nothing is changed. Gamepanion migrates its databases when it starts.

## whisper

speaches with `Systran/faster-whisper-small` (int8, about 500 MB in memory, at most 1.5 of the 2 vCPUs): `products-1` has 4 GB shared by three products, so the large model Gamepanion defaults to does not fit. speaches transcribes only models installed into `gamepanion/whisper/`; the deployment installs `GAMEPANION_TRANSCRIBE_MODEL` once (`POST /v1/models/<id>`), and the files stay there. Changing the model is that setting in the vault and a deployment.

## Backups

`gamepanion/scripts/dump.sh <kind> <days>` writes `data/dumps/<kind>-<time>/` with consistent, checked copies of `gamepanion.sqlite` and `auth.sqlite`. Timers on the server, set up by the deployment:

| Kind           | When                                                | Kept on the server |
| -------------- | --------------------------------------------------- | ------------------ |
| hourly         | every hour                                          | 1 day              |
| daily          | 03:15                                               | 30 days            |
| before-upgrade | each deployment that changes the checkout or `.env` | 1 day              |

Every night at 04:40 the newest daily dump also goes to the business's Storage Box: restic, into Gamepanion's own sub-account (`u707825-sub3`, home `/gamepanion`) and a repository with its own password, kept 29 days. A failed run alerts the ntfy topic; a run that doesn't happen is noticed by its healthchecks.io check.

`GAMEPANION_SECRET` is in no backup: it is in the vault and in 1Password. A dump without it restores the logs, but every browser and every Claude has to sign in again. The same holds for `GAMEPANION_KEY_ENCRYPTION_KEY`: without it the players' stored Anthropic keys can't be read, and they paste them again.

Once payments are on, `billing.sqlite` (who subscribes) is dumped with the other two.

## Restore

With Gamepanion stopped, from a dump on the server (`dump.sh` says the same):

```sh
cd /srv/stacks/gamepanion/gamepanion
docker compose stop gamepanion
rm -f data/*.sqlite-wal data/*.sqlite-shm
cp data/dumps/<kind>-<time>/gamepanion.sqlite data/dumps/<kind>-<time>/auth.sqlite data/
docker compose start gamepanion
```

From the Storage Box, as root on the server, into a folder; then copy the two files the same way:

```sh
export RESTIC_REPOSITORY=sftp:storagebox-gamepanion:restic RESTIC_PASSWORD_FILE=/etc/restic/gamepanion-password
restic -o sftp.command="ssh -F /etc/restic/ssh_config storagebox-gamepanion -s sftp" restore latest --target /var/tmp/restore
```

## Logs and monitoring

The container logs go to Loki on `gewerbe-1`, labelled `product=gamepanion`. Uptime Kuma watches `https://gamepanion.app/health` as a player reaches it, through DNS and Caddy (the `kuma.*` labels in `compose.yaml`). Caddy counts requests per host name for Prometheus; its lines and counts for gamepanion.app carry `product=gamepanion`.
