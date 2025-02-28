#!/bin/sh
set -e

COMMIT_MSG="$1"
BACKUP_MIRROR="$2"

RDIR="tmpfs-scratch/"

SED=sed
if command -v gsed >/dev/null; then
    SED=gsed
fi

mtik_backup() {
    RHOST="$1"
    RDOM="$2"
    RHOST_ABS="${RHOST}.${RDOM}"

    ssh "${RHOST_ABS}" "/system/backup/save dont-encrypt=yes name=${RDIR}${RHOST}-secret.backup"
    ssh "${RHOST_ABS}" "/export file=${RDIR}${RHOST}-secret.rsc show-sensitive terse"
    ssh "${RHOST_ABS}" "/export file=${RDIR}${RHOST}.rsc terse"

    sleep 1

    scp "${RHOST_ABS}:/${RDIR}${RHOST}-secret.backup" "${RHOST_ABS}:/${RDIR}${RHOST}-secret.rsc" "${RHOST_ABS}:/${RDIR}${RHOST}.rsc" ./
    if [ ! -z "${BACKUP_MIRROR}" ]
    then
        cp "${RHOST}-secret.backup" "${RHOST}-secret.rsc" "${RHOST}.rsc" "${BACKUP_MIRROR}"
    fi

    $SED 's~^# ....-..-.. ..:..:.. by RouterOS~# ____-__-__ __:__:__ by RouterOS~'  -i "${RHOST}.rsc"
    $SED 's~key=\\"[^"]*\\"~key=\\"REMOVED\\"~g' -i "${RHOST}.rsc"
    $SED 's~global DynDNSKey \\".*\\"~global DynDNSKey \\"REMOVED\\"~g' -i "${RHOST}.rsc"
    $SED 's~global IPv6Key \\".*\\"~global IPv6Key \\"REMOVED\\"~g' -i "${RHOST}.rsc"
    $SED 's~^# software id = .*$~# software id = REMOVED~g' -i "${RHOST}.rsc"
    $SED 's~^# system id = .*$~# system id = REMOVED~g' -i "${RHOST}.rsc"
    $SED 's~^# serial number = .*$~# serial number = REMOVED~g' -i "${RHOST}.rsc"
    $SED 's~private-key="[^"]*"~private-key="REMOVED"~g' -i "${RHOST}.rsc"
    $SED 's~name=monitor_[^ ]*~name=monitor_REMOVED~g' -i "${RHOST}.rsc"
    $SED 's~identity=[^ ]*~identity=REMOVED~g' -i "${RHOST}.rsc"
    $SED 's~comment=Hairpin dst-address=.* ~comment=Hairpin dst-address=REMOVED ~g' -i "${RHOST}.rsc"
    $SED 's~comment="Hairpin fallback" dst-address=.* ~comment="Hairpin fallback" dst-address=REMOVED ~g' -i "${RHOST}.rsc"
    $SED 's~name=6to4-router remote-address=.*$~name=6to4-router remote-qaddress=REMOVED~g' -i "${RHOST}.rsc"
    $SED 's~name=6to4-router-backup remote-address=.*$~name=6to4-router-backup remote-qaddress=REMOVED~g' -i "${RHOST}.rsc"
    $SED 's~network=[a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9]~network=REMOVED~g' -i "${RHOST}.rsc"

    sleep 1

    ssh "${RHOST_ABS}" "/file/remove ${RDIR}${RHOST}-secret.backup"
    ssh "${RHOST_ABS}" "/file/remove ${RDIR}${RHOST}-secret.rsc"
    ssh "${RHOST_ABS}" "/file/remove ${RDIR}${RHOST}.rsc"
}

mtik_backup router foxden.network
mtik_backup router-backup foxden.network
mtik_backup redfox doridian.net

git commit -a -m "${COMMIT_MSG}"
