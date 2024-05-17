#!/bin/sh
set -e

transfer_section() {
    SECTION="$1"
    WHERE="$2"
    WHERER="$3"
    if [ -z "$WHERER" ]
    then
        WHERER="$WHERE"
    fi

    echo "$SECTION" >> "$F"
    echo "remove [ find $WHERER ]" >> "$F"

    if [ ! -z "$WHERE" ]
    then
        ssh router.foxden.network "$SECTION/export show-sensitive terse where $WHERE" | dos2unix  >> "$F"
    else
        ssh router.foxden.network "$SECTION/export show-sensitive terse" | dos2unix >> "$F"
    fi
}

transfer_section_localclause() {
    transfer_section "$1" '(!(name~"^local-"))'
}

transfer_section_notdynamic() {
    transfer_section "$1" 'dynamic=no'
}

transfer_section_notdynamic_remove() {
    transfer_section "$1" '' 'dynamic=no'
}

F="$(mktemp)"
chmod 600 "$F"
echo > "$F"

transfer_section '/ip/dns/static'
transfer_section_notdynamic '/ip/dhcp-server/lease'
transfer_section_notdynamic_remove '/ip/firewall/filter'
transfer_section_notdynamic_remove '/ip/firewall/mangle'
transfer_section_notdynamic_remove '/ip/firewall/nat'
transfer_section_notdynamic_remove '/ipv6/firewall/filter'
transfer_section_notdynamic_remove '/ipv6/firewall/mangle'
transfer_section_localclause '/system/script'
transfer_section_localclause '/system/scheduler'

scp "$F" router-backup.foxden.network:/tmpfs-scratch/transfer.rsc
ssh router-backup.foxden.network "/import file-name=tmpfs-scratch/transfer.rsc"
sleep 1
ssh router-backup.foxden.network "/file remove tmpfs-scratch/transfer.rsc"

rm -f "$F"

ssh router-backup.foxden.network "/system/script/run firewall-update"

cd files
scp -r . "router.foxden.network:/"
scp -r . "router-backup.foxden.network:/"
cd ..
