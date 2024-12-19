# Local Ansible Setup

This repository provides an Ansible-based configuration to set up your local Ubuntu system with common packages, development tools, and shell configuration. It uses a single inventory file for your machine (localhost) and separates logic into roles with corresponding variables.

## Features

- **Separation of Concerns**: Variables are stored in `group_vars/` and tasks are modularized into roles (`common`, `shell`, `devtools`).
- **Idempotent Configuration**: Running the playbook multiple times applies changes only as needed.
- **Customizable via Group Vars**: Easily add or remove packages, tools, and configurations by editing the YAML files in `group_vars/`.

## Directory Structure

```
.
├── ansible.cfg               # Ansible configuration file
├── group_vars/
│   ├── all.yml               # Global variables for all tasks/roles
│   ├── apt.yml               # Variables related to apt packages
│   ├── asdf.yml              # Variables for asdf tool versions, etc.
│   ├── docker.yml            # Variables for Docker installation/config
│   ├── snap.yml              # Variables for Snap packages
│   ├── vscode.yml            # Variables for Visual Studio Code setup
│   └── zsh.yml               # Variables for Zsh and oh-my-zsh configuration
├── inventory.ini             # Inventory file (usually localhost)
├── Makefile                  # Make targets for easy commands (check, run)
├── playbook.yml              # Main Ansible playbook to run the whole setup
├── README.md                 # This documentation
├── roles/
│   ├── common/
│   │   └── tasks/
│   │       └── main.yml      # Common tasks (e.g., apt updates)
│   ├── devtools/
│   │   └── tasks/
│   │       ├── asdf.yml      # Install and configure asdf
│   │       ├── docker.yml    # Install and configure Docker
│   │       ├── main.yml      # Devtools entry tasks (include other yml)
│   │       ├── tabby.yml     # Install and configure Tabby terminal
│   │       └── vscode.yml    # Install and configure Visual Studio Code
│   └── shell/
│       ├── tasks/
│       │   ├── main.yml      # Shell related tasks (includes zsh.yml)
│       │   └── zsh.yml       # Zsh and oh-my-zsh setup tasks
│       └── templates/
│           └── zshrc.j2      # Template for .zshrc
└── scripts/
    ├── check_playbook.sh     # Script to lint/validate the Ansible playbook
    ├── install_ansible.sh    # Script to install Ansible
    ├── inventory_device.sh    # Script to generate/update inventory
    └── run_playbook.sh       # Wrapper script to run 'playbook.yml'
└── temp/                     # Temporary files (logs, caches, etc.)
```

## Prerequisites

1. **Ubuntu-based system**
2. **Ansible installed**: You can either install manually or run:
   ```bash
   ./scripts/install_ansible.sh
   ```
3. **Git** if you are cloning the repo:
   ```bash
   sudo apt update && sudo apt install -y git
   ```

## Configuration

Edit `group_vars/*.yml` files to set which packages, snap apps, docker configurations, VSCode extensions, etc., you want installed. For example, in `apt.yml` you can add packages:

```yaml
apt_packages:
  - git
  - curl
  - vim
```

In `zsh.yml`, set your shell configurations or oh-my-zsh theme. Adjust values according to your preferences.

## Usage

### Running the Setup

You have multiple ways to run the configuration.

**Option 1: Using the provided script**

```bash
./scripts/run_playbook.sh
```

This runs `playbook.yml` against `inventory.ini` on localhost, applying roles and tasks defined in `group_vars` and `roles/`.

**Option 2: Using ansible-playbook directly**

```bash
ansible-playbook -i inventory.ini playbook.yml
```

**Option 3: Using the Makefile**

- `make setup`: You can define a `setup` target in the Makefile to run `run_playbook.sh` or `ansible-playbook`. For example:

  ```bash
  make setup
  ```

### Checking the Playbook

You can validate your Ansible playbook with `ansible-lint` or other tooling via:

```bash
./scripts/check_playbook.sh
```

If integrated into the Makefile as `make check`:

```bash
make check
```

This ensures there are no syntax errors or linting issues before applying changes to your system.

## Tips & Troubleshooting

- **Permission Errors**: Some tasks require root privileges. The `become: yes` directive in `playbook.yml` ensures tasks that need `sudo` run with elevated privileges. Make sure you adjust roles and tasks accordingly if you run as a non-root user.
- **User-Specific Files**: If you’re installing dotfiles or configuring the shell, ensure that tasks run as the correct user. Use `become_user: <username>` in tasks that need to apply changes to the user’s home directory.
- **Variables and Overriding**: If you need to override variables, place them in the `group_vars/all.yml` or create host_vars. The variable precedence rules in Ansible let you customize configurations without changing code inside roles.

## Contributions

Feel free to open issues, suggest improvements, or submit pull requests to enhance the setup. Before sending a PR, run `make check` to ensure everything is linted and valid.

## License

This project is licensed under the [MIT License](LICENSE).
