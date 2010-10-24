# ssh tools
#

alias sshforward="sudo ssh -D 1080 -C -N -f -F $HOME/.ssh/config -l twl ssh.sauria.com"
alias killtunnels='sudo kill `ps auxw | grep ssh | grep root | cut -d" " -f6`'
alias showtunnnels="ps aux | grep ssh | grep root"

alias ssx='ssh -Y'  # note using Trusted X11 Forwarding and no compression
ssxbg () { 
  (ssx -n $* >& /dev/null &) 
}

alias shuttlex='ssxbg shuttle.sauria.com gnome-terminal'
