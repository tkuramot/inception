FROM gists/pure-ftpd:1.0.51

COPY ./conf/entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh"]

CMD /usr/sbin/pure-ftpd \
        -P $PUBLIC_HOST \
        -p $MIN_PASV_PORT:$MAX_PASV_PORT \
        -l puredb:/etc/pureftpd/pureftpd.pdb \
        -E \
        -j \
        -R
