#!/bin/sh
set -e

# Sørg for at katalogene i /share finnes (mappes fra HA)
mkdir -p /share/owntone/dbase_and_logs || true
mkdir -p /share/owntone/music || true

# Gi (for sikkerhets skyld) eierskap til UID/GID 1000, som Owntone-containeren bruker som standard
chown -R 1000:1000 /share/owntone || true

# Sørg for at /var/cache/owntone peker til /share/owntone/dbase_and_logs
rm -rf /var/cache/owntone
ln -s /share/owntone/dbase_and_logs /var/cache/owntone

# (Valgfritt) slå av IPv6 i config hvis fila finnes
if [ -f /etc/owntone.conf ]; then
  sed -i 's/^ipv6 *= *yes/ipv6 = no/' /etc/owntone.conf || true
fi

# Start Owntone i foreground med default configexec owntone -f
exec owntone -f
