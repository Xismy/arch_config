#!/usr/bin/env zsh

confirmed=false

while [ "$confirmed" = false ]
do
	zsh ~/.config/theme/theme_colors.zsh PREVIEW
	echo "Apply theme? (Y[es]/N[o]/E[dit])"
	answer=""
	while [ -z "$answer" ]
	do
		read -r answer
		case $answer in
			Y*|y*) confirmed=true ;;
			N*|n*) exit 0 ;;
			E*|e*) $EDITOR ~/.config/theme/theme_colors.zsh ;;
			*) echo Please answer Y, N or E ; answer="" ;;
		esac
	done
done

source ~/.config/theme/theme_colors.zsh

function to_rgba {
	local rgb=$1
	local r=${rgb:1:2}
	local g=${rgb:3:2}
	local b=${rgb:5:2}
	local a=$2

	setopt forcefloat
	echo "rgba($((16#$r)), $((16#$g)), $((16#$b)), $a)"
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
		print("'"@define-color theme_bg_color $(to_rgba ${THEME_BG_COLOR} 0.5);"'");
		print("'"@define-color theme_sec_bg_color $(to_rgba ${THEME_SEC_BG_COLOR} 0.5);"'");
		print("'"@define-color theme_emph_color ${THEME_EMPH_COLOR};"'");
		print("'"@define-color theme_sec_emph_color ${THEME_SEC_EMPH_COLOR};"'");
		print("'"@define-color theme_comp_emph_color ${THEME_COMP_EMPH_COLOR};"'");
		print("'"@define-color theme_inactive_color ${THEME_INACTIVE_COLOR};"'");
		print("'"@define-color theme_warning_color ${THEME_WARNING_COLOR};"'");
		print;\
		theme_printed=1;\
	}' \
	~/.config/waybar/style.css

awk -i inplace \
	'BEGIN {\
		theme_printed=0;\
	} \
	/^[ \t]*theme-/ {\
		if(!theme_printed) \
			next;\
		else {\
			print("Warning: defined color with theme- prefix after first block in ~/.config/rofi/theme.rasi") > "/dev/stderr";\
			print("If it is part of your theme define it in ~/.config/theme/theme_colors.zsh and run this script again") > "/dev/stderr";\
		}\

	} \
	/[ \t]*\{[ \t]*/ {\
		print;\
		next;\
	} \
	{\
		if(theme_printed) {\
			print;\
			next;\
		}\
		print("'"theme-fg-color: ${THEME_FG_COLOR};"'");
		print("'"theme-sec-fg-color: ${THEME_SEC_FG_COLOR};"'");
		print("'"theme-bg-color: ${THEME_BG_COLOR}80;"'");
		print("'"theme-sec-bg-color: ${THEME_SEC_BG_COLOR}80;"'");
		print("'"theme-emph-color: ${THEME_EMPH_COLOR};"'");
		print("'"theme-sec-emph-color: ${THEME_SEC_EMPH_COLOR};"'");
		print("'"theme-comp-emph-color: ${THEME_COMP_EMPH_COLOR};"'");
		print("'"theme-inactive-color: ${THEME_INACTIVE_COLOR};"'");
		print("'"theme-warning-color: ${THEME_WARNING_COLOR};"'");
		print;\
		theme_printed=1;\
	}' \
	~/.config/rofi/theme.rasi

pkill waybar
setsid waybar 2>/dev/null 1>/dev/null < /dev/null &

