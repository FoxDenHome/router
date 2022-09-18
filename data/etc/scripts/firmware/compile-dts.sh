#!/bin/sh
dtc -W no-unit_address_vs_reg -I dts -O dtb "$1" -o "$2"
