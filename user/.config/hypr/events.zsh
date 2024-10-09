#!/bin/zsh

HYPR_CURRENT_WS=1

function handle() {
	case $1 in
		workspace\>\>*)
			local target_ws=${1#workspace\>\>}
			img_idx=$(( (target_ws-1)%4+1 ))

			local transition=left
			if [ $target_ws -gt $HYPR_CURRENT_WS ]
			then
				transition=right 
			fi
			swww img --transition-type fade --transition-duration 0.5 ~/.config/wallpapers/desktop${img_idx}
			HYPR_CURRENT_WS=$target_ws
		;;
	esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done


