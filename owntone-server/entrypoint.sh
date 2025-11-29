#!/bin/sh
set -e

# Sørg for at katalogene i /share finnes (mappes fra HA)
mkdir -p /share/owntone/dbase_and_logs || true
mkdir -p /share/owntone/music || true

# Pek /var/cache/owntone til /share/owntone/dbase_and_logs (der databasen skal ligge)
rm -rf /var/cache/owntone
ln -s /share/owntone/dbase_and_logs /var/cache/owntone || true

# Sørg for at config-katalogen finnes
mkdir -p /etc/owntone || true

# Hvis vi ikke har noen config ennå, kopier eksempel-konfigen fra imaget
if [ ! -f /etc/owntone/owntone.conf ] && [ -f /usr/share/doc/owntone/examples/owntone.conf ]; then
  cp /usr/share/doc/owntone/examples/owntone.conf /etc/owntone/owntone.conf
fi

# Slå av IPv6 i config hvis fila finnes
if [ -f /etc/owntone/owntone.conf ]; then
  sed -i 's/^ipv6 *= *yes/ipv6 = no/' /etc/owntone/owntone.conf || true
fi

# Gi eierskap til standard owntone-bruker (uid/gid 1000 i offisielt image)
chown -R 1000:1000 /share/owntone || true

# Start OwnTone i foreground med vår config
exec owntone -f -c /etc/owntone/owntone.conf
