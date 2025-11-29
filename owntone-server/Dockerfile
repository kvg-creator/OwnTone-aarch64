FROM owntone/owntone:latest

# Installer avahi-daemon og dbus, som Owntone bruker til mDNS
RUN apt-get update && \
    apt-get install -y --no-install-recommends avahi-daemon dbus && \
    rm -rf /var/lib/apt/lists/*

# Vår egen entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
