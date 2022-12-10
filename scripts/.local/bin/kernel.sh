#!/bin/bash

echo "   running: $(uname -r)"
echo "filesystem: $(file /boot/vmlinuz-linux | cut -d' ' -f9)"

