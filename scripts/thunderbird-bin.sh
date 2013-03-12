#!/bin/bash

if [[ $(id -u) != 0 ]] 
then
  echo "You must be root to perform this"
  exit 1
fi


version=$1
download_url='http://ftp.mozilla.org/pub/mozilla.org/thunderbird/releases/latest/linux-x86_64/en-US'
filename="thunderbird-${version}.tar.bz2"

cd /tmp
[[ -d thunderbird ]] && rm -rf /tmp/thunderbird

if [[ ! -f ${filename} ]]
then 
    wget ${download_url}/${filename} || { echo "Problem downloading..."; exit 1; }
fi

tar -jxf ${filename} || { echo "Problem uncompressing..."; exit 1; }
 
cave import --location ./thunderbird \
            --install-under /opt/thunderbird-bin \
            --description 'Binary download from http://ftp.mozilla.org/pub/mozilla.org/thunderbird/releases/latest/linux-x86_64/en-US' \
            net-mail/thunderbird-bin ${version} 0

sleep 5

cave import --location ./thunderbird \
            --install-under /opt/thunderbird-bin \
            --description 'Binary download from http://ftp.mozilla.org/pub/mozilla.org/thunderbird/releases/latest/linux-x86_64/en-US' \
            net-mail/thunderbird-bin ${version} 0 -x


cd /tmp
[[ -d thunderbird ]] && rm -rf /tmp/thunderbird

