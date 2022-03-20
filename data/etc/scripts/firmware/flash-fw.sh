#!/bin/sh
mtd erase dpl && mtd write dpl.dtb dpl
mtd erase bl2 && mtd write bl2_qspi_xg1_1g.pbl bl2
