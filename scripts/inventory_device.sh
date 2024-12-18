#!/usr/bin/env bash

echo "=== Installed APT Packages ==="
dpkg -l | awk '/^ii/ { print $2 }'

echo
echo "=== Installed Snap Packages ==="
snap list

echo
echo "=== Dotfiles in Home Directory ==="
ls -a $HOME | grep "^\."