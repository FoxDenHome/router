#!/bin/sh
set -e

transfer_section() {
    SECTION="$1"
    WHERE="$2"
    SEDCLAUSE="$3"

    echo "$SECTION" >> "$F"
    echo "remove [ find $WHERE ]" >> "$F"

    if [ ! -z "$SEDCLAUSE" ]
    then
        ssh router "$SECTION/export show-sensitive terse" | dos2unix | sed "$SEDCLAUSE" >> "$F"
    else
        ssh router "$SECTION/export show-sensitive terse" | dos2unix >> "$F"
    fi
}

transfer_section_localclause() {
    transfer_section "$1" '(!(name~"^local-"))' 's~add .* name=local-~find name=local-~'
}

transfer_section_notdynamic() {
    transfer_section "$1" 'dynamic=no'
}

F="$(mktemp)"
chmod 600 "$F"
echo > "$F"

transfer_section '/ip/dns/static'
transfer_section_notdynamic '/ip/dhcp-server/lease'
transfer_section_notdynamic '/ip/firewall/filter'
transfer_section_notdynamic '/ip/firewall/nat'
transfer_section_notdynamic '/ipv6/firewall/filter'
transfer_section_localclause '/system/script'
transfer_section_localclause '/system/scheduler'

scp "$F" router-backup:/tmpfs-scratch/transfer.rsc
ssh router-backup "/import file-name=tmpfs-scratch/transfer.rsc"
sleep 1
ssh router-backup "/file remove tmpfs-scratch/transfer.rsc"

rm -f "$F"
