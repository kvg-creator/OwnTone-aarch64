# Bygg på offisiell Owntone-container
FROM owntone/owntone:latest

# Sørg for at /share finnes (mappes inn av Home Assistant via "map: share:rw")
RUN mkdir -p /share/owntone/music \
    && mkdir -p /share/owntone/dbase_and_logs

# Pek /var/cache/owntone til /share/owntone/dbase_and_logs
# slik at database.db og cache.db havner på et skrivbart sted
RUN rm -rf /var/cache/owntone && \
    ln -s /share/owntone/dbase_and_logs /var/cache/owntone

# (Valgfritt) juster IPv6 i config hvis fila finnes
RUN if [ -f /etc/owntone.conf ]; then \
      sed -i 's/^ipv6 *= *yes/ipv6 = no/' /etc/owntone.conf || true; \
    fi

# Vi bruker entrypoint/cmd fra base-image (starter owntone)
