FROM owntone/owntone:29.0

# Lag kataloger i /share (som er mappet inn av Home Assistant via map: share:rw)
RUN mkdir -p /share/owntone/dbase_and_logs \
    && mkdir -p /share/owntone/music \
    && rm -rf /var/cache/owntone \
    && ln -s /share/owntone/dbase_and_logs /var/cache/owntone

# Viktig: la base-image sin init fortsette som før.
# I owntone/owntone er CMD satt til /sbin/init (OpenRC),
# så vi trenger ikke å sette ENTRYPOINT/CMD selv – vi arver den.
