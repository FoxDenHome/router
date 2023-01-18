#!/bin/sh
set -e



transfer_section() {
    SECTION="$1"

    DATA="$(ssh router "$SECTION/export show-sensitive" | dos2unix)"

    echo "$SECTION" > "$F"
    echo "remove [find]" >> "$F" 
    echo "$DATA" >> "$F"
}

F="$(mktemp)"
chmod 600 "$F"

transfer_section '/ip/dns/static'
transfer_section '/ip/dhcp-server/lease'
transfer_section '/ip/firewall/filter'
transfer_section '/ip/firewall/nat'
transfer_section '/ipv6/firewall/filter'

scp "$F" router-backup:/tmpfs-scratch/transfer.rsc
ssh router-backup "/import file-name=tmpfs-scratch/transfer.rsc"
sleep 1
ssh router-backup "/file remove tmpfs-scratch/transfer.rsc"

rm -f "$F"
