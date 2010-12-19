export LESSOPEN="| /usr/bin/lesspipe %s"

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
		notify-send "took $elapsed secs" ${PREEXEC_CMD:-Some Command}
	fi
}

autoload -U add-zsh-hook
add-zsh-hook precmd stopwatch_precmd
add-zsh-hook preexec stopwatch_preexec
export SYSTEM_NOTIFIER='notify-send'

[[ -e /etc/bash_completion.d/virtualenvwrapper ]] && . /etc/bash_completion.d/virtualenvwrapper
