# macOS

Disable input source on cursor

```
sudo defaults write /Library/Preferences/FeatureFlags/Domain/UIKit.plist redesigned_text_cursor -dict-add Enabled -bool NO

# Revert
sudo defaults delete /Library/Preferences/FeatureFlags/Domain/UIKit.plist redesigned_text_cursor
```

# Window SSH Setup

```
Get-WindowsCapability -Name OpenSSH.Server* -Online |
    Add-WindowsCapability -Online
Set-Service -Name sshd -StartupType Automatic -Status Running

if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
    New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
} else {
    Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
}

$shellParams = @{
    Path         = 'HKLM:\SOFTWARE\OpenSSH'
    Name         = 'DefaultShell'
    Value        = 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe'
    PropertyType = 'String'
    Force        = $true
}
New-ItemProperty @shellParams
```
