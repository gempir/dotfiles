# Remove existing files
Remove-Item -Path "C:\Users\gempir\AppData\Roaming\Chatterino2\Settings\commands.json" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Users\gempir\AppData\Roaming\Chatterino2\Settings\window-layout.json" -Force -ErrorAction SilentlyContinue

# Create symbolic links
New-Item -ItemType SymbolicLink -Path "C:\Users\gempir\AppData\Roaming\Chatterino2\Settings\commands.json" -Target "C:\Users\gempir\dotfiles\files\chatterino\commands.json" -Force
New-Item -ItemType SymbolicLink -Path "C:\Users\gempir\AppData\Roaming\Chatterino2\Settings\window-layout.json" -Target "C:\Users\gempir\dotfiles\files\chatterino\window-layout.json" -Force