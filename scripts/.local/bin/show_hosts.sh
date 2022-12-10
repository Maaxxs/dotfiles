#!/bin/bash

# Shows all hosts in the first private network (first IP starting with 192.)
# Uses nmap, so you need that installed

NETWORK=$(ip a | grep -E 'inet 192[^ ]+' -o -m1 | cut -d' ' -f 2)
HOST_IP=$(echo $NETWORK | cut -d'/' -f1)

echo This host\'s IP: $HOST_IP
echo Looking for hosts in $NETWORK

nmap $NETWORK -sn | grep 'report for' | cut -d' ' -f 5,6 | grep -v $HOST_IP

