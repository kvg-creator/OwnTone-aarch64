#!/bin/sh
set -e

# --- Start avahi/dbus for mDNS ---

# Sørg for at runtime-katalogene finnes
mkdir -p /run/dbus /var/run/dbus /var/run/avahi-daemon || true

# Start system-dbus (noen ganger feiler den hvis allerede kjører, derfor "|| echo")
dbus-daemon --system || echo "dbus-daemon already running or failed"

# Start avahi-daemon (daemoniserer selv med -D)
avahi-daemon -D || echo "avahi-daemon failed to start"

# --- Forbered mapper for OwnTone ---

mkdir -p /share/owntone/dbase_and_logs || true
mkdir -p /share/owntone/music || true

# Pek /var/cache/owntone til samme sted som database/logg
rm -rf /var/cache/owntone
ln -s /share/owntone/dbase_and_logs /var/cache/owntone || true

# Skriv en minimal, men gyldig config vi kontrollerer selv
cat > /share/owntone/owntone.conf <<EOF
general {
  uid = "root"
  db_path = "/share/owntone/dbase_and_logs/database.db"
  logfile = "/share/owntone/dbase_and_logs/owntone.log"
  loglevel = log
}

library {
  directories = { "/share/owntone/music" }
}
EOF

# --- Start OwnTone i foreground med vår config ---

exec owntone -f -c /share/owntone/owntone.conf
