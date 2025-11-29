# Bygg på offisiell Owntone-container
FROM owntone/owntone:latest

# Lag kataloger i /share som mappes fra Home Assistant
RUN mkdir -p /share/owntone/music \
    && mkdir -p /share/owntone/dbase_and_logs

# Juster standardkonfig slik at bibliotek, database og logg bruker /share
RUN if [ -f /etc/owntone.conf ]; then \
      sed -i 's#/srv/music#/share/owntone/music#g' /etc/owntone.conf || true; \
      sed -i 's#/var/cache/owntone/database.db#/share/owntone/dbase_and_logs/database.db#g' /etc/owntone.conf || true; \
      sed -i 's#/var/cache/owntone/cache.db#/share/owntone/dbase_and_logs/cache.db#g' /etc/owntone.conf || true; \
      sed -i 's#/var/log/owntone.log#/share/owntone/dbase_and_logs/owntone.log#g' /etc/owntone.conf || true; \
      sed -i 's/^ipv6 *= *yes/ipv6 = no/' /etc/owntone.conf || true; \
    fi

# Bruker entrypoint/cmd fra base-image (starter owntone)
