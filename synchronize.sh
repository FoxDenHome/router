#!/bin/sh
set -e

transfer_section() {
    SECTION="$1"
    WHERE="$2"
    SEDCLAUSE="$3"

    echo "$SECTION" > "$F"
    echo "remove [ find $WHERE ]" >> "$F"

    if [ ! -z "$SEDCLAUSE" ]
    then
        ssh router "$SECTION/export show-sensitive terse" | dos2unix | sed "$SEDCLAUSE" >> "$F"
    else
        ssh router "$SECTION/export show-sensitive terse" | dos2unix >> "$F"
    fi
}

F="$(mktemp)"
chmod 600 "$F"

transfer_section '/ip/dns/static'
transfer_section '/ip/dhcp-server/lease'
transfer_section '/ip/firewall/filter'
transfer_section '/ip/firewall/nat'
transfer_section '/ipv6/firewall/filter'
transfer_section '/system/script' 'name!="init-onboot"' 's~add .* name=init-onboot ~find ~'

scp "$F" router-backup:/tmpfs-scratch/transfer.rsc
ssh router-backup "/import file-name=tmpfs-scratch/transfer.rsc"
sleep 1
ssh router-backup "/file remove tmpfs-scratch/transfer.rsc"

rm -f "$F"
