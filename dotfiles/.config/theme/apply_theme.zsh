#!/bin/zsh
source ~/.config/theme/theme_colors.zsh

function to_rgba {
	local color=$1
	local r=${color:1:2}
	local g=${color:3:2}
	local b=${color:5:2}
	local a=${color:7:2}
	setopt forcefloat
	echo "rgba($((16#$r)), $((16#$g)), $((16#$b)), $((16#$a/255)))"
}

echo > $ZDOTDIR/.theme \
"export ZCOLOR0=\"${THEME_SEC_EMPH_COLOR}\"\n"\
"export ZCOLOR1=\"${THEME_EMPH_COLOR}\"\n"\
"export ZCOLOR2=\"${THEME_SEC_FG_COLOR}\"\n"\
"export ZCOLOR3=\"${THEME_SEC_BG_COLOR:0:7}\"\n"\

awk -i inplace \
	'BEGIN {\
		theme_printed=0;\
	} \
	/^[ \t]*@define-color theme_/ {\
		if(!theme_printed) \
			next;\
		else {\
			print("Warning: defined color with theme_ prefix after first block in ~/.config/waybar/style.css") > "/dev/stderr";\
			print("If it is part of your theme define it in ~/.config/theme/theme_colors.zsh and run this script again") > "/dev/stderr";\
		}\

	} \
	{\
		if(theme_printed) {\
			print;\
			next;\
		}\
		print("'"@define-color theme_fg_color ${THEME_FG_COLOR};"'");
		print("'"@define-color theme_sec_fg_color ${THEME_SEC_FG_COLOR};"'");
		print("'"@define-color theme_bg_color ${THEME_BG_COLOR};"'");
		print("'"@define-color theme_sec_bg_color $(to_rgba ${THEME_SEC_BG_COLOR});"'");
		print("'"@define-color theme_emph_color ${THEME_EMPH_COLOR};"'");
		print("'"@define-color theme_sec_emph_color ${THEME_SEC_EMPH_COLOR};"'");
		print("'"@define-color theme_inactive_color ${THEME_INACTIVE_COLOR};"'");
		print("'"@define-color theme_warning_color ${THEME_WARNING_COLOR};"'");
		print;\
		theme_printed=1;\
	}' \
	~/.config/waybar/style.css

pkill waybar
setsid waybar 2>/dev/null 1>/dev/null < /dev/null &

