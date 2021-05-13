#!/bin/bash
# Measure the throughput of different ciphers

# \time always calls the GNU time command, not the builtin shell command.
# if not installed, the package is usually called 'time'
# ssh key authentication must be enabled and working for the user and host.

# size in MB
SIZE=1000
# ssh user@host
SSH_TARGET="$1"

for i in `ssh -Q cipher`; do dd if=/dev/zero bs=1M count=$SIZE 2> /dev/null \
  | ssh -c $i $SSH_TARGET "(\time -p cat) > /dev/null" 2>&1 \
  | grep real | awk '{print "'$i': "'$SIZE' / $2" MB/s" }'; done
