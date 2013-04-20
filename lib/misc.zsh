## smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

## file rename magick
bindkey "^[m" copy-prev-shell-word

## jobs
setopt long_list_jobs

## pager
export PAGER=less
export LC_CTYPE=$LANG

# TWL
export REPORTTIME=5
export READNULLCMD='less'

setopt nohup ignoreeof
setopt noclobber
setopt printexitvalue

setopt autocontinue checkjobs
setopt pathdirs
setopt chaselinks

