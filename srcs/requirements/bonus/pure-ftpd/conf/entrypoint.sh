#!/bin/sh
set -eux

addgroup -g ${GID} -S ftpgroup && adduser -u ${UID} -G ftpgroup -h /home/ftpuser -D -s /sbin/nologin ftpuser

[[ $(stat -c %U /home/ftpuser) == "ftpuser" ]] || chown -R ftpuser /home/ftpuser
[[ $(stat -c %G /home/ftpuser) == "ftpgroup" ]] || chgrp -R ftpgroup /home/ftpuser

# add user if not exist
if ! pure-pw list | grep -q $FTP_USER; then
  /usr/bin/pure-pw useradd $FTP_USER -u ftpuser -d /home/ftpuser <<-EOF
		$FTP_PASSWORD
		$FTP_PASSWORD
	EOF
fi

[[ -f /etc/pureftpd/pureftpd.passwd ]] && /usr/bin/pure-pw mkdb
/usr/bin/pure-pw list

exec "$@"
