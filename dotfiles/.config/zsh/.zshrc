setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt PROMPT_SUBST

source $ZDOTDIR/theme_colors.zsh

zmodload zsh/complist

autoload -Uz compinit
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

compinit
add-zsh-hook precmd vcs_info

zstyle ':completion:*' menu select
zstyle ':vcs_info:*' formats "%F{$ZCOLOR3}◖%f%K{$ZCOLOR3} %b %F{$ZCOLOR3}%k◗%f"
zstyle ':vcs_info:*' enable git

bindkey -v
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fpath=(/usr/share/zsh/site-functions/ $fpath)

PROMPT=\
'%F{${ZCOLOR0}}%B╭─[%F{${ZCOLOR1}}%n%F{${ZCOLOR0}}󰣇%F{${ZCOLOR1}}%m%F{${ZCOLOR0}}:%F{${ZCOLOR2}}%d%F{${ZCOLOR0}}] ${vcs_info_msg_0_}'$'\n'\
'%F{${ZCOLOR0}}%B╰─→%b%f'
