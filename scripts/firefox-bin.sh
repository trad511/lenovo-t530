#!/bin/bash

if [[ $(id -u) != 0 ]] 
then
  echo "You must be root to perform this"
  exit 1
fi


version=$1
download_url='http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/en-US'
filename="firefox-${version}.tar.bz2"

cd /tmp
[[ -d firefox ]] && rm -rf /tmp/firefox

if [[ ! -f ${filename} ]]
then 
    wget ${download_url}/${filename} || { echo "Problem downloading..."; exit 1; }
fi

tar -jxf ${filename} || { echo "Problem uncompressing..."; exit 1; }
 
cave import --location ./firefox \
            --install-under /opt/firefox-bin \
            --description 'Binary download from http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/en-US' \
            net-www/firefox-bin ${version} 0

sleep 5

cave import --location ./firefox \
            --install-under /opt/firefox-bin \
            --description 'Binary download from http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-x86_64/en-US' \
            net-www/firefox-bin ${version} 0 -x


cd /tmp
[[ -d firefox ]] && rm -rf /tmp/firefox
