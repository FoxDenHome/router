#!/bin/sh
set -e

MSG="$1"
DST="$2"

ssh root@router.foxden.network 'sysupgrade -b -' > router.tar.gz
rm -rf data
mkdir -p data
tar -xzf router.tar.gz -C data

redact() {
	KEY="$1"
	FILE="$2"
	if [ "$(uname)" = "Linux" ]
	then
		sed "s/${KEY}.*\$/${KEY} 'REMOVED'/g" -i "data${FILE}"
	else
		sed -i '' "s/${KEY}.*\$/${KEY} 'REMOVED'/g" "data${FILE}"
	fi
}

redact 'option private_key' /etc/config/network
redact 'option password' /etc/config/network
redact 'option updatekey' /etc/config/network
redact 'option password' /etc/config/ddns

git add -A
git commit -a -m "$MSG" || true

if [ ! -z "$DST" ]
then
	rm -f "$DST/router.tar.gz"
	cp router.tar.gz "$DST/router.tar.gz"
fi
