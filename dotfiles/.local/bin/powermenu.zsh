#/bin/zsh
commands=('poweroff' 'reboot' 'niri msg action quit')

idx=$(printf 'Turn off\nReboot\nLog out' | fuzzel --dmenu --index)
${commands[$(( idx ))]}
