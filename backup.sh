#!/bin/sh
set -e

MSG="$1"
DST="$2"

ssh root@router 'sysupgrade -b -' > router.tar.gz
rm -rf data
mkdir -p data
tar -xzf router.tar.gz -C data

redact() {
	KEY="$1"
	FILE="$2"
	sed -i '' "s/${KEY}.*\$/${KEY} 'REMOVED'/g" "data${FILE}"
}

redact 'option private_key' /etc/config/network
redact 'option password' /etc/config/ddns

git add -A
git commit -a -m "$MSG"
git push

if [ ! -z "$DST" ]
then
	rm -f "$DST/router.tar.gz"
	cp router.tar.gz "$DST/router.tar.gz"
fi
