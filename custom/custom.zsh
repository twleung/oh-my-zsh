#!/bin/zsh

export LESS='-CeMqs'
export PAGER='less'
#export MANPAGER='most -s'

#
# zle
#

# keybindings
bindkey -me 2> /dev/null # emacs mode with meta bits turned on and warning suppressed
bindkey "\M-\b" backward-kill-word
bindkey "\C- " set-mark-command
bindkey "\C-w" kill-region

# word characters
typeset WORDCHARS='*?_[]~&;!#$%^(){}<>' # word characters for ZLE

#
# aliases
# 

# global aliases - swiped from http://grml.org/zsh/zsh-lovers.html

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g CA="2>&1 | cat -A"
alias -g C='| wc -l'
alias -g D="DISPLAY=:0.0"
alias -g DN=/dev/null
alias -g ED="export DISPLAY=:0.0"
alias -g EG='|& egrep'
alias -g EH='|& head'
alias -g EL='|& less'
alias -g ELS='|& less -S'
alias -g ETL='|& tail -20'
alias -g ET='|& tail'
alias -g F=' | fmt -'
alias -g G='| egrep'
alias -g H='| head'
alias -g HL='|& head -20'
alias -g Sk="*~(*.bz2|*.gz|*.tgz|*.zip|*.z)"
alias -g LL="2>&1 | less"
alias -g L="| less"
alias -g LS='| less -S'
alias -g MM='| most'
alias -g M='| more'
alias -g NE="2> /dev/null"
alias -g NS='| sort -n'
alias -g NUL="> /dev/null 2>&1"
alias -g PIPE='|'
#alias -g R=' > /c/aaa/tee.txt '
alias -g RNS='| sort -nr'
alias -g S='| sort'
alias -g TL='| tail -20'
alias -g T='| tail'
alias -g US='| sort -u'
alias -g VM=/var/log/messages
alias -g X0G='| xargs -0 egrep'
alias -g X0='| xargs -0'
alias -g XG='| xargs egrep'
alias -g X='| xargs'

# my global aliases
alias -g FRM='-exec rm {} \;'
alias -g FRMD='-exec rmdir {} \;'

#eval `dircolors ~/.dircolors`
export ZLS_COLORS=$LS_COLORS
alias l='ls -F'
alias lt='ls -Ft'
alias lth='ls -Ft | head'
alias la='ls -Fa'
alias lah='ls -Fa | head'
alias ll='ls -Fl'
alias llh='ls -Flh'
alias lla='ls -Fla'
alias llr='ls -FRl'
alias llt='ls -Flt'
alias llth='ls -Flt | head'
alias lr='ls -FR'
alias lls='ls -FlS'
alias dir='ll'

# directory stack aliases
alias dh='dirs -v'
alias p='pushd'
alias P='popd'

alias du1='du -hs *(/)'

alias grep='grep --color=auto'

# cvs
alias cdh='cvs diff -r HEAD'
alias cdhl='cvs diff -r HEAD |& less'
alias cqu='cvs -qn update'

# svn
alias sdh='svn diff --revision HEAD'
alias sdhl='svn diff --revision HEAD |& less'

#
# misc aliases
#
alias cp='nocorrect cp -i'
alias mkdir='nocorrect mkdir'
alias diff='diff -u'
alias gps='ps aux | grep'
alias h='fc -lDd -100 -1'
alias j='jobs -l'
alias more='less'
alias mv='nocorrect mv -i'
alias mlt='mail twl@sauria.com'
alias prmail='less /var/mail/twl'
alias psu='ps aux | grep $USER'
alias psug='ps aux | grep $USER | grep '
alias gps='ps aux | grep'
alias vtree='find . -type d -print | sed 1d | sed '\''s:/\([^/]*\)$:/+---\1:;s:./::;s:[^/]*/:|   :g'\'''
alias wh='whence -va'

# this is voodoo.  This is a zsh parameter expansion to fit the form of 
# Flickr image files.  It is set to a *global* alias so that you could do
# stuff like: ls flickr_glob

alias -g flickr_glob='${(l:45::[0-9]:)~:-}_${(l:80::[0-9a-f]:)~:-}(|_[bo])(.jpg|.png)'

#
# Python stuff
#

alias pythonhttp="python -c '__import__(\"SimpleHTTPServer\").test()\'"
alias pygrep='find . -name "*.py" -print0 | xargs -0 grep'
alias jython="java -jar $HOME/work/sun/jython/dist/jython.jar"

alias twldelicious="wget --http-user=twleung --http-passwd=zztop1 -O $HOME/Documents/delicious-twleung.xml 'http://del.icio.us/api/posts/all'"

#
# zsh functions
#
mcd () { 
  mkdir $1;
  cd $1 
}

mkmv () {
  mkdir $1;
  mv $2 $1
}

rfgrep () {
  find . -type f -a -name "$1" -print0 | xargs -0 grep -i $2
}

en1 () { enscript -1RGp- $* }
en1s () { enscript -1RGp- -fCourier7 $* }
en1rs () { enscript -1rGp- -fCourier7 $* }
en2 () { enscript -2rGp - $* }
enl () { enscript -1Rlp - $* }

# use highlight to highlight a python file for printing
pyhighlight () { highlight -Spy -sprint -i $1 -o ~/tmp/$1:t.html }
pypp () { a2ps --line-numbers=1 --chars-per-line=100 $1 }

check-pgp-signed () {
  gpg --list-sigs $1 | grep twl@sauria.com
  gpg --list-sigs twl@sauria.com | grep $1
}

alias twget='http_proxy=$TOR_PROXY wget'
alias tcurl='http_proxy=$TOR_PROXY curl'
alias whatismyip='curl automation.whatismyip.com/n09230945.asp'

# via http://www.20seven.org/blog/articles/2008/03/10/twitter-updates-from-terminal/
# NOTE STILL BUGGY on quoting
ztweet() {
 curl -u twleung:zztop1 -d status=\"$*\" http://twitter.com/statuses/update.xml
}

typeset -U dirstack

# via http://radio.weblogs.com/0100945/2005/04/27.html#a604
zq () {
  # function zq -- cd, qualified by searching the dirstack.
  #  take only the LAST (== most recent) directory that matches.  NoIC.
  #  zq_dest=$( dh | grep "$1" | tail -1 )
  zq_dest=$( dirs -v | grep "$1" | head -1 )
  set -- $=zq_dest
#  echo pushd ${(j:\ :)argv[2,${#argv}]}
  eval pushd "${(j:\ :)argv[2,${#argv}]}"
}
#zstyle ':completion:*:*:zq:*:*' tag-order directory-stack


# via http://radio.weblogs.com/0100945/2005/04/27.html#a604
zf () {
  # zf is "cd to a file's directory"
  dir="${1%/*}"
  pushd "$dir"
  unset dir
  pushd .     # Make the window title look right.
}

# remove $2 from the path (w/o $) indicated by $1
# i.e 'remove-from-path path /usr/local/bin'
# based on rationalize-path in http://zsh.sunsite.dk/Contrib/startup/users/debbiep/dot.zshenv
remove-from-path () {             
  # Note that this works only on arrays, not colon-delimited strings.
  # Not that this is a problem now that there is typeset -T.
  local element
  local build
  build=()
  # Evil quoting to survive an eval and to make sure that
  # this works even with variables containing IFS characters, if I'm
  # crazy enough to setopt shwordsplit.
  eval '
  foreach element in "$'"$1"'[@]"
  do
    if [[ -d "$element" && "$element" != $2 ]]
    then
      build=("$build[@]" "$element")
    fi
  done
  '"$1"'=( "$build[@]" )
  '
}

#via https://twitter.com/#!/dysinger/status/177520557351374849
function each() {
    x=$1;
    shift;
    for y in `find $PWD -name $x`;do 
	pushd "`dirname $y`";$@;popd;
    done
}
# example: each .git git remote update

#via https://gist.github.com/nriley/34d92c9eb2eaf1073c04

ts() {
    local tspty=tspty.$(/usr/bin/uuidgen)
    zmodload zsh/zpty
    zpty $tspty $@
    setopt localtraps
    TRAPINT() { zpty -d $tspty }
    while zpty -r $tspty line; do
        print -Pn '%B%D{%m/%d %H:%M:%S}%b '
        print -n -- $line
    done
}

setopt cdablevars
dirstack=(~ ~/work ~/work/clojure ~/work/clojure/cljs ~/work/scala ~/work/couchdb ~/work/js ~/work/js/node.js ~/work/js/coffeescript ~/work/haskell ~/work/erlang ~/work/cocoa ~/work/python ~/.oh-my-zsh ~/.emacs.d ~/work/DIS)

autoload zmv
ttyctl -f

source $HOME/Library/Preferences/org.dystroy.broot/launcher/bash/br
