autoload -U add-zsh-hook
autoload -Uz vcs_info

add-zsh-hook precmd twl_prompt_precmd

grey='\e[0;90m'

twl_prompt_precmd() {
    vcs_info 'prompt'
    RPROMPT=$'%{$fg[white]%}${VIRTUAL_ENV:t}'
}

zstyle ':vcs_info:*' formats \
    '%s:%b%c%u'
zstyle ':vcs_info:*' actionformats \
    '%s:%b|%a%c%u'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b:%r'
# check-for-changes can be really slow.
# you should disable it, if you work with large repositories
# zstyle ':vcs_info:hg*:netbeans' check-for-changes false
zstyle ':vcs_info:*:prompt:*' check-for-changes true
zstyle ':vcs_info:(hg*|git):*' unstagedstr "%{$fg_bold[magenta]:U$reset_color%}"
zstyle ':vcs_info:(hg*|git):*' stagedstr "%{$fg_bold[magenta]:S$reset_color%}"


PROMPT=$'%{%{$fg[magenta]%}%D{[%I:%M:%S]} $fg[green]%}[%n@%m] %{$reset_color%}[%~]%{$reset_color%} $fg[cyan]($vcs_info_msg_0_$fg[cyan])%{$reset_color%}\
%{$fg[yellow]%}[%h]>%{$fg_bold[blue]%}%{$reset_color%} '

#http://geoff.greer.fm/lscolors/
LSCOLORS=cxfxexdxbxegedabagacad

