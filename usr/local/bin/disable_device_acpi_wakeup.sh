#!/bin/bash 

# From Lenovo T530 /proc/acpi/wakeup
# Want wakeup on LID and SLPB change.  Disable rest
#
#Device	S-state	  Status   Sysfs node
#LID	  S4	*enabled 
#SLPB	  S3	*enabled 
#IGBE	  S4	*disabled  pci:0000:00:19.0
#EXP3	  S4	*disabled  pci:0000:00:1c.2
#XHCI	  S3	*disabled  pci:0000:00:14.0
#EHC1	  S3	*disabled  pci:0000:00:1d.0
#EHC2	  S3	*disabled  pci:0000:00:1a.0
#HDEF	  S4	*disabled  pci:0000:00:1b.0


#[[ $(id -u) == 0 ]] || exit 1

FILE="/proc/acpi/wakeup"

for device in IGBE XHCI EHC1 EHC2 HDEF
do

  #
  # Returns enabled|disabled for device wakeup
  #
  state=$(
            grep ${device} ${FILE} | \
            tr -d '*' | \
            tr -s [:space:] ' ' | \
            cut -d ' ' -f 3
         )

  #
  # Disable device if it's enabled
  #
  if [[ ${state:-disabled} == 'enabled' ]]
  then
     echo ${device} > ${FILE}
  fi

done
