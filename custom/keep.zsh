# keep functions http://www.unixreview.com/documents/s=9513/ur0501a/
    function keep {
        setopt localoptions nomarkdirs nonomatch nocshnullglob nullglob
        kept=()		# Erase old value in case of error on next line
        kept=($~*)
	if [[ ! -t 0 ]]; then
            local line
            while read line; do
                kept+=( $line )   # += is a zsh 4.2+ feature
            done
        fi
        print -Rc - ${^kept%/}(T)
    }
alias keep='noglob keep'
_insert_kept() {
    (( $#kept )) || return 1
    local action
    zstyle -s :completion:$curcontext insert-kept action
    if [[ -n $action ]]
    then compstate[insert]=$action
    elif [[ $WIDGET = *expand* ]]
    then compstate[insert]=all
    fi
    if [[ $WIDGET = *expand* ]]
    then compadd -U ${(M)kept:#${~words[CURRENT]}}
    else compadd -a kept
    fi
}      
_expand_word_and_keep() {
    function compadd() {
        local -A args
        zparseopts -E -A args J:
        if [[ $args[-J] == all-expansions ]]
        then
            builtin compadd -A kept "$@"
            kept=( ${(Q)${(z)kept}} )
        fi
        builtin compadd "$@"
    }
    local result
    _main_complete _expand
    result=$?
    unfunction compadd
    return result
}      
zle -C insert-kept-result complete-word _insert_kept
bindkey '^Xk' insert-kept-result
zstyle ':completion:expand-kept-result:*' completer _insert_kept      

zle -C expand-kept-result complete-word _generic
zstyle ':completion:expand-kept-result:*' completer _insert_kept      
zle -C _expand_word complete-word _expand_word_and_keep      
bindkey '^XK' expand-kept-result      
# end keep #######################################################
