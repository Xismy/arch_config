setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt PROMPT_SUBST

autoload -Uz compinit
compinit

zmodload zsh/complist
zstyle ':completion:*' menu select
bindkey -v
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fpath=(/usr/share/zsh/site-functions/ $fpath)

PROMPT=\
'%F{#99ccff}%B╭─[%F{#00ffaa}%n%F{#99ccff}󰣇%F{#00ffaa}%m%F{#99ccff}:%F{#ffd700}%d%F{#99ccff}]'$'\n'\
'%F{#99ccff}%B╰─→%b%f'
