#!/bin/sh
set -e

# Sørg for at katalogene i /share finnes (mappes fra HA)
mkdir -p /share/owntone/dbase_and_logs || true
mkdir -p /share/owntone/music || true

# (Valgfritt, men greit) pek /var/cache/owntone til samme sted som db_path
rm -rf /var/cache/owntone
ln -s /share/owntone/dbase_and_logs /var/cache/owntone || true

# Lag en helt enkel owntone-config vi har full kontroll over
cat > /share/owntone/owntone.conf <<EOF
general {
  uid = "root"
  db_path = "/share/owntone/dbase_and_logs/database.db"
  logfile = "/share/owntone/dbase_and_logs/owntone.log"
  loglevel = log
}

library {
  # Her kan du senere legge inn en annen mappe hvis du vil
  directories = { "/share/owntone/music" }
}
EOF

# Start OwnTone i foreground med vår egen config
exec owntone -f -c /share/owntone/owntone.conf
