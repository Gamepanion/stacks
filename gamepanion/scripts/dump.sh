#!/usr/bin/env bash
# One copy of Gamepanion's two databases into ../data/dumps, and the old copies of the same kind removed.
#
#   dump.sh <kind> <days to keep>      e.g.  dump.sh hourly 1
#
# Each run makes a folder <kind>-<time>/ with gamepanion.sqlite (the players' logs) and auth.sqlite (sign-in, sessions,
# passkeys, connected clients), and billing.sqlite (subscriptions) once payments are on and it exists. Each is a consistent `sqlite3 .backup` taken while Gamepanion writes (needs sqlite3 on the
# host, and to run as the user the container runs as, 1000), checked with PRAGMA integrity_check, and the folder gets its
# real name only once both are whole. Old folders of the kind are removed only after a new one succeeded. The secret is not
# in a dump: on the server it is GAMEPANION_SECRET in the deployment's vault.
#
# To restore, with Gamepanion stopped (docker compose stop gamepanion; docker compose start gamepanion afterwards):
#   rm -f data/gamepanion.sqlite-wal data/gamepanion.sqlite-shm data/auth.sqlite-wal data/auth.sqlite-shm
#   cp data/dumps/<kind>-<time>/gamepanion.sqlite data/dumps/<kind>-<time>/auth.sqlite data/
#   (and billing.sqlite, with its -wal and -shm removed the same way, when the dump has one)
set -euo pipefail

kind=${1:?the kind of dump, e.g. hourly}
keep_days=${2:?how many days to keep dumps of this kind}
[[ $kind =~ ^[a-z][a-z0-9-]*$ ]] || { echo "dump: the kind may hold only a-z, 0-9 and -" >&2; exit 2; }
[[ $keep_days =~ ^[0-9]+$ ]] || { echo "dump: the days to keep must be a number" >&2; exit 2; }

data=${DUMP_DATA_DIR:-$(cd "$(dirname "$0")/.." && pwd)/data}
dir="$data/dumps"

umask 077
mkdir -p "$dir"
stamp=$(date -u +%Y%m%dT%H%M%SZ)
out="$dir/$kind-$stamp"
tmp="$out.tmp"
trap 'rm -rf "$tmp"' EXIT
mkdir "$tmp"

dbs=(gamepanion auth)
[[ -f $data/billing.sqlite ]] && dbs+=(billing)
for db in "${dbs[@]}"; do
  [[ -f $data/$db.sqlite ]] || { echo "dump: $data/$db.sqlite is missing" >&2; exit 1; }
  sqlite3 "$data/$db.sqlite" ".backup '$tmp/$db.sqlite'"
  [[ $(sqlite3 "$tmp/$db.sqlite" 'PRAGMA integrity_check;') == ok ]] || { echo "dump: the copy of $db.sqlite is not intact" >&2; exit 1; }
done
mv "$tmp" "$out"

# Older than the days to keep, of this kind only; never the one just made.
find "$dir" -maxdepth 1 -mindepth 1 -type d -name "$kind-*Z" ! -path "$out" -mmin +$((keep_days * 1440)) -exec rm -rf {} +
echo "dump: $(basename "$out")"
