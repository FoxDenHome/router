#!/bin/sh
set -e

COMMIT_MSG="$1"
BACKUP_MIRROR="$2"

RDIR="tmpfs-scratch/"

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

    sed -i '' 's~^# .../../.... ..:..:.. by RouterOS~# ---/--/---- --:--:-- by RouterOS~' "${RHOST}.rsc"
    sed -i '' 's~key=\\"[^"]*\\"~key=\\"REMOVED\\"~g' "${RHOST}.rsc"
    sed -i '' 's~global DynDNSKey \\".*\\"~global DynDNSKey \\"REMOVED\\"~g' "${RHOST}.rsc"
    sed -i '' 's~^# software id = .*$~# software id = REMOVED~g' "${RHOST}.rsc"
    sed -i '' 's~^# serial number = .*$~# serial number = REMOVED~g' "${RHOST}.rsc"
    sed -i '' 's~name=monitor_[^ ]*~name=monitor_REMOVED~g' "${RHOST}.rsc"
    sed -i '' 's~identity=[^ ]*~identity=REMOVED~g' "${RHOST}.rsc"
    sed -i '' 's~network=[a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9]~network=REMOVED~g' "${RHOST}.rsc"

    sleep 1

    ssh "${RHOST_ABS}" "/file/remove ${RDIR}${RHOST}-secret.backup"
    ssh "${RHOST_ABS}" "/file/remove ${RDIR}${RHOST}-secret.rsc"
    ssh "${RHOST_ABS}" "/file/remove ${RDIR}${RHOST}.rsc"
}

mtik_backup router
mtik_backup router-backup
#mtik_backup switch-dori-office-10g

git commit -a -m "${COMMIT_MSG}"
