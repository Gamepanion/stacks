# stacks

How [gamepanion.app](https://gamepanion.app) runs [Gamepanion](https://github.com/gamepanion/gamepanion): the compose file of the server and what it needs. Public, as a worked example of a production setup; take what is useful.

| Folder        | What runs                                                                                                                  | Reachable                                                                                                                                  |
| ------------- | -------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| `gamepanion/` | Gamepanion (SQLite in `data/`) and whisper (speaches, speech to text for the chat); `scripts/dump.sh` copies the databases | Gamepanion on the server's private address only (port 8082), where the Caddy on gewerbe-1 passes requests on; whisper from Gamepanion only |

gamepanion.app runs on `products-1`, next to notefeed.me and gesetze-fuer-ki.de. The collectors of that server are in [notefeed/stacks](https://github.com/notefeed/stacks); Caddy and the certificates are on `gewerbe-1`, the business's one public entry point (`caddy/` in the private MarcelBruckner-Business/stacks).

## How it is used

This repository is checked out on the server. A companion repository, private because it holds the inventory and the secrets, writes `gamepanion/.env`, runs `docker compose up`, installs whisper's model and sets up the backups. So:

- **There are no secrets and no server addresses in here.** `.env.example` lists the names; the values are written on the server.
- **Nobody edits files on the server.** A change is a commit here, then a deployment.
- **Versions are pinned.** Dependabot opens a pull request when a new image exists; merging it and deploying is the upgrade.

How it is operated (backups, restore, upgrades, whisper) is in [docs/operations.md](docs/operations.md).

## Trying it yourself

```sh
cp gamepanion/.env.example gamepanion/.env   # fill it in; PRIVATE_IP=127.0.0.1 on a single machine
mkdir -p gamepanion/data gamepanion/whisper && sudo chown 1000:1000 gamepanion/data gamepanion/whisper
(cd gamepanion && docker compose up -d)
docker exec gamepanion-whisper curl -fsS -X POST http://localhost:8000/v1/models/Systran/faster-whisper-small
```

The settings are explained in Gamepanion's [documentation](https://github.com/gamepanion/gamepanion/blob/main/docs/self-hosting/configuration.md).
