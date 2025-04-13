if (!
    #current role
    (New-Object Security.Principal.WindowsPrincipal(
        [Security.Principal.WindowsIdentity]::GetCurrent()
    #is admin?
    )).IsInRole(
        [Security.Principal.WindowsBuiltInRole]::Administrator
    )
) {
    #elevate script and exit current non-elevated runtime
    Start-Process `
        -FilePath 'powershell' `
        -ArgumentList (
            #flatten to single array
            '-File', $MyInvocation.MyCommand.Source, $args `
            | %{ $_ }
        ) `
        -Verb RunAs
    exit
}

# Remove existing files
Remove-Item -Path "C:\Users\gempir\AppData\Roaming\Chatterino2\Settings\commands.json" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Users\gempir\AppData\Roaming\Chatterino2\Settings\window-layout.json" -Force -ErrorAction SilentlyContinue

# Create symbolic links
New-Item -ItemType SymbolicLink -Path "C:\Users\gempir\AppData\Roaming\Chatterino2\Settings\commands.json" -Target "C:\Users\gempir\dotfiles\files\chatterino\commands.json" -Force
New-Item -ItemType SymbolicLink -Path "C:\Users\gempir\AppData\Roaming\Chatterino2\Settings\window-layout.json" -Target "C:\Users\gempir\dotfiles\files\chatterino\window-layout.json" -Force