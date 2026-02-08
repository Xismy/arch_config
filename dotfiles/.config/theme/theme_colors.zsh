THEME_FG_COLOR="#FFFFFF"
THEME_SEC_FG_COLOR="#ffd700"
THEME_BG_COLOR="#263238"
THEME_SEC_BG_COLOR="#64727d"
THEME_EMPH_COLOR="#00ffaa"
THEME_SEC_EMPH_COLOR="#99ccff"
THEME_COMP_EMPH_COLOR="#263238"
THEME_INACTIVE_COLOR="#505050"
THEME_WARNING_COLOR="#ffaa00"

if [ "$1" = "PREVIEW" ]
then
	print -P "%F{${THEME_FG_COLOR}}%K{${THEME_BG_COLOR}} This is a test %f%k"
	print -P "%F{${THEME_SEC_FG_COLOR}}%K{${THEME_SEC_BG_COLOR}} This is a secondary test %f%k"
	print -P "%F{${THEME_EMPH_COLOR}}%K{${THEME_BG_COLOR}} This is an emphasis test %f%k"
	print -P "%F{${THEME_COMP_EMPH_COLOR}}%K{${THEME_EMPH_COLOR}} This is a complementary emphasis test %f%k"
	print -P "%F{${THEME_SEC_EMPH_COLOR}}%K{${THEME_BG_COLOR}} This is a secondary emphasis test %f%k"
	print -P "%F{${THEME_COMP_EMPH_COLOR}}%K{${THEME_SEC_EMPH_COLOR}} This is a complementary secondary emphasis test %f%k"
	print -P "%F{${THEME_INACTIVE_COLOR}}%K{${THEME_BG_COLOR}} This is an inactive test %f%k"
	print -P "%F{${THEME_WARNING_COLOR}}%K{${THEME_BG_COLOR}} This is a warning test %f%k"
fi
