# Dotfiles

A cross-platform dotfiles management system using Ansible.

## Features

- Unified approach for managing dotfiles across multiple platforms:
  - macOS
  - Linux
  - Windows
- Automated setup using Ansible for consistent configuration
- Smart dependency handling through the uv package manager

## Setup Instructions

### Prerequisites

- Git (to clone this repository)

### Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/dotfiles.git
cd dotfiles
```

2. Run the appropriate bootstrap script for your platform:

#### For macOS or Linux:
```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

#### For Windows:
```powershell
# Run PowerShell as Administrator
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
.\bootstrap_windows.ps1
```

The bootstrap script will automatically:
1. Install Python if not already installed
2. Install the uv package manager
3. Use uv to install Ansible
4. Run the appropriate Ansible playbook for your operating system

### Manual Ansible Run

If you've already installed Ansible, you can run the playbooks directly:

#### For macOS:
```bash
ansible-playbook -i "localhost," -c local playbooks/macos.yml
```

#### For Linux:
```bash
ansible-playbook -i "localhost," -c local playbooks/linux.yml
```

#### For Windows:
```powershell
ansible-playbook -i "localhost," -c local playbooks/windows.yml
```

## File Structure

```
dotfiles/
├── bootstrap.sh               # Bootstrap script for macOS and Linux
├── bootstrap_windows.ps1      # Bootstrap script for Windows
├── playbooks/                 # Ansible playbooks
│   ├── linux.yml              # Linux playbook
│   ├── macos.yml              # macOS playbook
│   └── windows.yml            # Windows playbook
├── roles/                     # Ansible roles
│   ├── common/                # Shared configurations
│   │   └── tasks/
│   │       └── main.yml
│   ├── linux/                 # Linux-specific configurations
│   │   └── tasks/
│   │       └── main.yml
│   ├── macos/                 # macOS-specific configurations
│   │   └── tasks/
│   │       └── main.yml
│   └── windows/               # Windows-specific configurations
│       └── tasks/
│           └── main.yml
└── ... (configuration files)
```

## Customization

To add or modify dotfiles:

1. Add your configuration files to the appropriate location in the repository
2. Update the relevant task file in `roles/<platform>/tasks/main.yml`
3. Run the appropriate Ansible playbook to apply changes

## License

MIT
