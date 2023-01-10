#!/bin/sh
set -e

COMMIT_MSG="$1"
BACKUP_MIRROR="$2"

mtik_backup() {
    RHOST="$1"

    ssh "${RHOST}" "/system/backup/save dont-encrypt=yes name=${RHOST}-secret.backup"
    ssh "${RHOST}" "/export file=${RHOST}-secret.rsc show-sensitive"
    ssh "${RHOST}" "/export file=${RHOST}.rsc"

    sleep 1

    scp "${RHOST}:/${RHOST}-secret.backup" "${RHOST}:/${RHOST}-secret.rsc" "${RHOST}:/${RHOST}.rsc" ./
    if [ ! -z "${BACKUP_MIRROR}" ]
    then
        cp "${RHOST}-secret.backup" "${RHOST}-secret.rsc" "${RHOST}.rsc" "${BACKUP_MIRROR}"
    fi

    sed -i '' 's~local key \\".*\\"~local key \\"REMOVED\\"~g' "${RHOST}.rsc"
    sed -i '' 's~^# software id = .*$~# software id = REMOVED~g' "${RHOST}.rsc"
    sed -i '' 's~^# serial number = .*$~# serial number = REMOVED~g' "${RHOST}.rsc"
    sed -i '' 's~name=monitor_.*~name=monitor_REMOVED~g' "${RHOST}.rsc"

    sleep 1

    ssh "${RHOST}" "/file/remove ${RHOST}-secret.backup"
    ssh "${RHOST}" "/file/remove ${RHOST}-secret.rsc"
    ssh "${RHOST}" "/file/remove ${RHOST}.rsc"
}

mtik_backup router
mtik_backup switch-dori-office-10g

git commit -a -m "${COMMIT_MSG}"
