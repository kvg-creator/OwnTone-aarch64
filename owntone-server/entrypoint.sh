#!/bin/sh
set -e

# Sørg for at katalogene i /share finnes (mappes fra HA)
mkdir -p /share/owntone/dbase_and_logs || true
mkdir -p /share/owntone/music || true

# Pek /var/cache/owntone til /share/owntone/dbase_and_logs (skrivbart område)
rm -rf /var/cache/owntone
ln -s /share/owntone/dbase_and_logs /var/cache/owntone || true

# Sørg for at config-katalogen finnes
mkdir -p /etc/owntone || true

# Hvis vi ikke har noen config ennå, prøv å kopiere eksempel-konfig
if [ ! -f /etc/owntone/owntone.conf ]; then
  if [ -f /usr/share/doc/owntone/examples/owntone.conf ]; then
    cp /usr/share/doc/owntone/examples/owntone.conf /etc/owntone/owntone.conf
  elif [ -f /etc/owntone.conf ]; then
    # fallback hvis imaget bruker /etc/owntone.conf som standard
    cp /etc/owntone.conf /etc/owntone/owntone.conf
  fi
fi

# Juster konfig hvis den finnes
if [ -f /etc/owntone/owntone.conf ]; then
  # slå av IPv6 hvis den er på
  sed -i 's/^ipv6 *=.*/ipv6 = no/' /etc/owntone/owntone.conf || true
  # kjør som root inne i containeren (unngår feil "Could not lookup user owntone")
  sed -i 's/^uid *=.*/uid = "root"/' /etc/owntone/owntone.conf || true
fi

# Start OwnTone i foreground med vår konfig
exec owntone -f -c /etc/owntone/owntone.conf
