#!/usr/bin/env bash
set -e

# Check if ansible is installed
if ! command -v ansible >/dev/null 2>&1; then
    echo "Ansible not found. Installing Ansible..."
    sudo apt update
    sudo apt install -y ansible
else
    echo "Ansible is already installed."
fi
