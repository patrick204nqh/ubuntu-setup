#!/usr/bin/env bash
set -e

# Run the ansible playbook
ansible-playbook playbook.yml --check --ask-become-pass
