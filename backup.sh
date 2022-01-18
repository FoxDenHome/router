#!/bin/sh

ssh router '/system/backup/save dont-encrypt=yes name=router-secret.backup'
ssh router '/export file=router-secret.rsc show-sensitive'
ssh router '/export file=router.rsc'

sleep 1

scp router:/router-secret.backup router:/router-secret.rsc router:/router.rsc ./
if [ ! -z "$2" ]
then
    cp router-secret.backup router-secret.rsc router.rsc "$2"
fi

sleep 1

ssh router '/file/remove router-secret.backup'
ssh router '/file/remove router-secret.rsc'
ssh router '/file/remove router.rsc'

git commit -a -m "$1" && git push
