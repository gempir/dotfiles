# bootstrap_windows.ps1
# Script to set up dotfiles on Windows using Ansible

# Ensure script is run as administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Please run this script as Administrator"
    exit 1
}

Write-Host "===================" -ForegroundColor Cyan
Write-Host "Setting up dotfiles on Windows" -ForegroundColor Cyan
Write-Host "===================" -ForegroundColor Cyan

# Install uv package manager
if (!(Get-Command uv -ErrorAction SilentlyContinue)) {
    Write-Host "Installing uv package manager..." -ForegroundColor Cyan
    powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
    # Refresh environment variables
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

uv python install
uv venv

# Install Ansible using uv
Write-Host "Installing Ansible using uv..." -ForegroundColor Cyan
uv pip install ansible pywinrm

# Run the Ansible playbook
Write-Host "Running Ansible playbook for Windows..." -ForegroundColor Cyan
ansible-playbook -i "localhost," -c local "playbooks/windows.yml"

Write-Host "===================" -ForegroundColor Cyan
Write-Host "Dotfiles setup complete!" -ForegroundColor Cyan
Write-Host "===================" -ForegroundColor Cyan
