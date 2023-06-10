#!/bin/sh
set -e

COMMIT_MSG="$1"
BACKUP_MIRROR="$2"

RDIR="tmpfs-scratch/"

SED=sed
if command -v gsed; then
    SED=gsed
fi

mtik_backup() {
    RHOST="$1"
    RHOST_ABS="${RHOST}.foxden.network"

    ssh "${RHOST_ABS}" "/system/backup/save dont-encrypt=yes name=${RDIR}${RHOST}-secret.backup"
    ssh "${RHOST_ABS}" "/export file=${RDIR}${RHOST}-secret.rsc show-sensitive terse"
    ssh "${RHOST_ABS}" "/export file=${RDIR}${RHOST}.rsc terse"

    sleep 1

    scp "${RHOST_ABS}:/${RDIR}${RHOST}-secret.backup" "${RHOST_ABS}:/${RDIR}${RHOST}-secret.rsc" "${RHOST_ABS}:/${RDIR}${RHOST}.rsc" ./
    if [ ! -z "${BACKUP_MIRROR}" ]
    then
        cp "${RHOST}-secret.backup" "${RHOST}-secret.rsc" "${RHOST}.rsc" "${BACKUP_MIRROR}"
    fi

    $SED 's~^# .../../.... ..:..:.. by RouterOS~# ---/--/---- --:--:-- by RouterOS~'  -i "${RHOST}.rsc"
    $SED 's~key=\\"[^"]*\\"~key=\\"REMOVED\\"~g' -i "${RHOST}.rsc"
    $SED 's~global DynDNSKey \\".*\\"~global DynDNSKey \\"REMOVED\\"~g' -i "${RHOST}.rsc"
    $SED 's~^# software id = .*$~# software id = REMOVED~g' -i "${RHOST}.rsc"
    $SED 's~^# serial number = .*$~# serial number = REMOVED~g' -i "${RHOST}.rsc"
    $SED 's~name=monitor_[^ ]*~name=monitor_REMOVED~g' -i "${RHOST}.rsc"
    $SED 's~identity=[^ ]*~identity=REMOVED~g' -i "${RHOST}.rsc"
    $SED 's~network=[a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9]~network=REMOVED~g' -i "${RHOST}.rsc"

    sleep 1

    ssh "${RHOST_ABS}" "/file/remove ${RDIR}${RHOST}-secret.backup"
    ssh "${RHOST_ABS}" "/file/remove ${RDIR}${RHOST}-secret.rsc"
    ssh "${RHOST_ABS}" "/file/remove ${RDIR}${RHOST}.rsc"
}

mtik_backup router
mtik_backup router-backup
#mtik_backup switch-dori-office-10g

git commit -a -m "${COMMIT_MSG}"
