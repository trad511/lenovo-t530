#!/bin/bash

set -x

ipt="/sbin/iptables"


#
# Interface definitions
#
wired="enp0s25"
wifi="wlp3s0"


#
# Flush tables
#
$ipt -F INPUT
$ipt -F FORWARD
$ipt -F OUTPUT


#
# Default policies
#
$ipt -P INPUT DROP
$ipt -P FORWARD ACCEPT
$ipt -P OUTPUT ACCEPT


#
# Base rules
#
$ipt -A INPUT -i lo -j ACCEPT
$ipt -A INPUT -p icmp -j ACCEPT


#
# Stateful rule
#
$ipt -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT


#
# SSH
#
#$ipt -A INPUT -m limit --limit 5/second -p tcp --dport 22 -j ACCEPT
$ipt -A INPUT -m state --state NEW -p tcp --dport 22 -j ACCEPT






