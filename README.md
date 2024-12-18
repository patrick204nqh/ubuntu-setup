# Ubuntu Setup Automation

This repository provides a consistent, low-side-effect method to set up a new Ubuntu work environment using Ansible and version-controlled dotfiles.

## Features

- Installs common packages and development tools.
- Configures shell environment.
- Symlinks dotfiles from this repo into your home directory.
- Safe defaults: minimal side effects and idempotent configurations.

## Prerequisites

- Ubuntu-based system.
- `git` and `ansible` installed:
  ```bash
  sudo apt update
  sudo apt install -y git ansible
  ```
- (Optional) Set up your SSH keys and git credentials before running:
  ```bash
  ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
  git config --global user.name "Your Name"
  git config --global user.email "your_email@example.com"
  ```

## How to Use

1. Clone this repository:

   ```bash
   git clone https://github.com/patrick204nqh/ubuntu-setup.git
   cd ubuntu-setup
   ```

2. Review and adjust variables in:

   - `ansible/playbooks/vars.yml`
   - Role variables in `ansible/roles/*/vars/main.yml`

3. Dry-run (no changes made):

   ```bash
   ./scripts/master_setup.sh --check
   ```

   Review the output to ensure no unexpected changes.

4. Apply changes:

   ```bash
   ./scripts/master_setup.sh
   ```

5. Re-run whenever you make adjustments. The setup is idempotent.

## How to Get Parameters From the Current Device

If you want to replicate the configuration of an existing Ubuntu environment, you can first inventory the currently installed packages, snaps, and dotfiles on that device. This helps you determine which tools and configurations to add to your Ansible roles and `dotfiles/` directory.

**What you can gather:**

- **Installed APT Packages**: Use `dpkg` to list currently installed packages.
- **Installed Snap Packages**: Use `snap list` to see which snaps are installed.
- **User Dotfiles**: Check your home directory for configuration files (e.g., `.zshrc`, `.vimrc`, `.gitconfig`).

**Example Commands:**

```bash
#!/usr/bin/env bash

echo "=== Installed APT Packages ==="
dpkg -l | awk '/^ii/ { print $2 }'

echo
echo "=== Installed Snap Packages ==="
snap list

echo
echo "=== Dotfiles in Home Directory ==="
ls -a $HOME | grep "^\."
```

To automate this process, you can use the provided `inventory_device.sh` script. This script collects information and prints it out, allowing you to review and incorporate it into your Ansible roles and `dotfiles/` repository.

**Usage:**

```bash
./scripts/inventory_device.sh
```

This will output lists of installed packages, snaps, and dotfiles. You can then edit your `ansible/roles/packages/vars/main.yml` (for apt and snap packages) and update your `dotfiles/` directory accordingly.

## Safe Practices

- Always run with `--check` first on a new environment.
- Keep this repo version-controlled and review changes before applying.

## Customization

- Add or remove packages in `ansible/roles/packages/vars/main.yml`.
- Update or add dotfiles in the `dotfiles/` directory.
- Modify shell preferences in `ansible/roles/shell/vars/main.yml`.
