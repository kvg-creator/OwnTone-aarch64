# Bygg på offisiell Owntone-container som har støtte for flere arkitekturer (inkl. ARM)
FROM owntone/owntone:latest

# Opprett kataloger i /share som vi kommer til å mounte fra Home Assistant
RUN mkdir -p /share/owntone/music \
    && mkdir -p /share/owntone/dbase_and_logs || true

# Juster standardkonfig hvis den finnes, slik at bibliotek, database og logg
# bruker /share i stedet for interne paths i containeren
RUN if [ -f /etc/owntone.conf ]; then \
      sed -i 's#/srv/music#/share/owntone/music#g' /etc/owntone.conf || true; \
      sed -i 's#/var/cache/owntone/songs3.db#/share/owntone/dbase_and_logs/songs3.db#g' /etc/owntone.conf || true; \
      sed -i 's#/var/cache/owntone/cache.db#/share/owntone/dbase_and_logs/cache.db#g' /etc/owntone.conf || true; \
      sed -i 's#/var/log/owntone.log#/share/owntone/dbase_and_logs/owntone.log#g' /etc/owntone.conf || true; \
      sed -i 's/^ipv6 *= *yes/ipv6 = no/' /etc/owntone.conf || true; \
    fi

# Vi bruker entrypoint/cmd fra det offisielle imaget, så ingen ekstra script er nødvendig her.
