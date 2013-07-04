#!/bin/bash

[[ "$1" == "pre"  ]] && { echo disable > /proc/acpi/ibm/bluetooth; logger "BT OFF"; }
[[ "$1" == "post" ]] && { echo enable  > /proc/acpi/ibm/bluetooth; logger "BT ON"; }

exit 0
