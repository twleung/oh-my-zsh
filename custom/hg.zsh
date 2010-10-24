# Mercurial jigs via http://naleid.com/blog/2008/11/25/my-mercurial-setup-plus-some-useful-shims-and-jigs/

vcst() {
	# print out all of the files with a passed in status flag (M - modified, A - added, ? - unknown, etc) (default ?)
	# expects first parameter to be the version control command (likely svn or hg)
	STATUS='\?'
	if [ -n "$2" ]
	then
		STATUS=$2
	fi
	$1 status | egrep "^$STATUS" | awk '{print $2}'
}

alias svnst='vcst svn'
alias hgst='vcst hg'

# look for lists of files in piped output, sort the unique set of them and print them one per line
lf() {
    egrep "^files:" | awk '{for (i=2; i<=NF; i++) print $i}' | sort | uniq 
}
 
alias ic="hg incoming -v | lf"
alias og="hg outgoing -v | lf"

hgtarget() {
    hg_root=`hg root 2>&1 | egrep -v "$abort:"`
   	if [ $hg_root ]; then
    	if [ -f $hg_root/.hg/hgrc ]; then
        	hg_target=`cat $hg_root/.hg/hgrc | egrep "^default =" | sed 's/\(^default = \(http:\/\/\)*\)\(.*@\)*//'`
        	echo "$hg_target"
        fi
    fi
}

hgbranch() {
	hg_root=`hg root 2>&1 | egrep -v "$abort:"`
	if [ $hg_root ]; then
		hg_branch=`hg branch`
		echo "$hg_branch"
	fi
}

