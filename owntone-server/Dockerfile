FROM owntone/owntone:latest

# Kopier inn vår egen entrypoint som fikser kataloger og så starter owntone
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
