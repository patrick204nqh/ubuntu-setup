#!/usr/bin/env bash

set -e

# Navigate to the script's directory
cd "$(dirname "$0")"

CHECK_MODE=false

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --check) CHECK_MODE=true ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
    shift
done

# Ensure ansible is installed
if ! command -v ansible-playbook &> /dev/null; then
    echo "Ansible is not installed. Please run: sudo apt install ansible"
    exit 1
fi

cd ..

if [ "$CHECK_MODE" = true ]; then
    echo "Running in check mode (dry-run)..."
    ansible-playbook ansible/playbooks/setup.yml -i ansible/inventory --check
else
    echo "Applying configuration to system..."
    ansible-playbook ansible/playbooks/setup.yml -i ansible/inventory
    echo "Setup completed successfully!"
fi