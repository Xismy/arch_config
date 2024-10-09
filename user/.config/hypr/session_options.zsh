#!/bin/zsh
sessionOptions=(
	'Apagar'
	'Reiniciar'
	'Cerrar sesión'
)

typeset -A sessionOptionsCommands
sessionOptionsCommands=(
	'Apagar' 'poweroff'
	'Reiniciar' 'reboot'
	'Cerrar sesión' 'hyprctl dispatch exit'
)

function printOptions() {
	for option in $sessionOptions
	do
		echo $option
	done
}

option=$(printOptions | wofi --show dmenu)
eval $sessionOptionsCommands[$option]
