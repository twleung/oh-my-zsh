#!/bin/zsh
export LESSOPEN="|/usr/local/bin/lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1

cdpath=($cdpath $HOME/Library "$HOME/Library/Application Support")

alias top='/usr/bin/top -ocpu -R -F -s 2 -n30'

alias battery-ioreg='ioreg -l | grep -i IOBatteryInfo'
alias subEthaEdit='open -a SubEthaEdit '
alias SubEthaEdit='open -a SubEthaEdit '
alias md5sum='/sbin/md5'

# hibernation control on OS X - via http://www.almaer.com/blog/archives/001182.html
alias hibernateon='sudo pmset -a hibernatemode 1'
alias hibernateoff='sudo pmset -a hibernatemode 0'

# quit and relaunch from http://www.macosxhints.com/article.php?story=20040623231530448
quit () {
        for app in $*; do
                osascript -e 'quit app "'$app'"'
        done
}

relaunch () {
        for app in $*; do
                osascript -e 'quit app "'$app'"';
                open -a $app
        done
}

#
# NetNewsWire aliases
#

#these 2 alias are now shell scripts
alias compareNNWTabs='diff ~/Library/Application\ Support/NetNewsWire/Tabs.plist ~/Documents/NNW/Tabs.plist'
#alias nnwTabUrls='xpath-query.py -q "/plist/array/dict/key[text() = \"url\"]/following-sibling::string/text()" ~/Library/Application\ Support/NetNewsWire/BrowserTabs.plist'
alias grabciteulike='saveCiteULike.py >/tmp/c;cat ~/citeulike /tmp/c |sort |uniq >| /tmp/d; mv /tmp/d ~/citeulike'
function killThumbs() {
  find ~/Library/Caches/NetNewsWire/TabThumbnails.noindex -type f -a -name "*_flickr_com_photos*" -a -atime +3 -exec rm {} \;
  find ~/Library/Caches/NetNewsWire/TabThumbnails.noindex -type f -a -name "*500px_com*" -a -atime +3 -exec rm {} \;
}

alias killds_stores='find . -type f -a -name .DS_Store -exec rm {} \;'

# quicksilver dates via http://forums.blacktree.com/viewtopic.php?p=6192#6192
alias qsdatefull="date \"+%Y/%m/%d (%a) @ %H:%M:%S\" | qs"
alias qsdateonly="date \"+%Y/%m/%d\" | qs"
alias qsdatetime="date \"+%H:%M:%S\" | qs"

# via jwalker@codefab.com on osxhack
alias killem='IFSTemp=$IFS IFS=$IFS[3] thePS=(`ps`); IFS=$IFSTemp; select i in $thePS; do; if [[ x$REPLY = xq ]] then break; fi; echo kill $i[(w)1]; kill $i[(w)1]; done'

# check for dictionary attacks - via http://www.macintouch.com/security-mon.html
function check-dict-attacks() {
  sudo grep "failed to auth" /var/log/secure.log \
  | sed "s/^.*user \(.*\) for.*$/\1/" | sort | uniq -c
}

# via http://www.commandlinefu.com/commands/view/2440/use-quicklook-from-the-command-line-without-verbose-output
function qlook() { qlmanage -p "$@" >& /dev/null & }
function ql() { qlmanage -p "$@" >& /dev/null & }

#via http://weblog.savanne.be/153-performance-tip-of-the-day
function vacuum-firefox () {
  for f in ~/Library/Application\ Support/Firefox/Profiles/*/*.sqlite; do
    sqlite3 "$f" 'VACUUM;';
  done
}

# via http://www.macosxhints.com/article.php?story=20071009124425468

# called before each command and starts stopwatch
function stopwatch_preexec () {
	export PREEXEC_CMD="$1"
	export PREEXEC_TIME=$(date +'%s')
#	print $PREEXEC_CMD >>/tmp/log
#	print $PREEXEC_TIME >>/tmp/log
}


# called after each command, stops stopwatch
# and notifies if time elpsed exceeds threshold
function stopwatch_precmd () {
	stop=$(date +'%s')
	start=${PREEXEC_TIME:-$stop}
	let elapsed=$(($stop-$start))
#	print "precmd $PREEXEC_TIME" >>/tmp/log
#	print $start >>/tmp/log
#	print $stop >>/tmp/log
#	print $elapsed >>/tmp/log
	max=${PREEXEC_MAX:-3}

	if [[ $elapsed > $max ]]; then
    /usr/local/bin/terminal-notifier iTerm -title $PREEXEC_CMD -message "took $elapsed secs"
#    		growlnotify -n "iTerm" -m "took $elapsed secs"
	fi
}

# via https://gist.github.com/808151
alias to-github="grep github ./.git/config | sed -e 's/^.*\(github.com.*\)\.git$/\1/' -e 's/.*github\.com:*\/*/https:\/\/github.com\//' | xargs open"

# https://github.com/alloy/terminal-notifier
alias terminal-notifier=~/bin/Darwin/terminal-notifier.app/Contents/MacOS/terminal-notifier

# choosy

function choosy() {
  open x-choosy://open/$1
}

autoload -U add-zsh-hook
add-zsh-hook precmd stopwatch_precmd
add-zsh-hook preexec stopwatch_preexec

[[ -e /usr/local/bin/virtualenvwrapper.sh ]] && . /usr/local/bin/virtualenvwrapper.sh
if (($+comamands[workon])); then # execute workon only if present
  workon darwin
fi
