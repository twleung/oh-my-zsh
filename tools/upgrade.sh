echo -e "\033[0;34mUpgrading Oh My Zsh\033[0m"

git_branches=`git remote -v`
#echo "branches"
#echo $git_branches
default_origin=`echo $git_branches | egrep 'origin\s+https://github.com/robbyrussell/oh-my-zsh\.git'`
#echo "default origin"
#echo $default_origin
upgrade_cmd="git pull origin master"
if [ "N$default_origin" = "N" ]; then
	upstream_branch=`echo $git_branches | egrep 'upstream\s+https://github.com/robbyrussell/oh-my-zsh\.git'`
#	echo "Upstream branch"
#	echo $upstream_branch
	if [ "N$upstream_branch" != "N" ]; then
		upgrade_cmd="git remote add upstream https://github.com/robbyrussell/oh-my-zsh/; git fetch upstream; git merge upstream/master"
	else
		upgrade_cmd="git fetch upstream; git merge upstream/master"
	fi
fi

( cd $ZSH && eval "$upgrade_cmd" )

echo -e "\033[0;32m"'         __                                     __   '"\033[0m"
echo -e "\033[0;32m"'  ____  / /_     ____ ___  __  __   ____  _____/ /_  '"\033[0m"
echo -e "\033[0;32m"' / __ \/ __ \   / __ `__ \/ / / /  /_  / / ___/ __ \ '"\033[0m"
echo -e "\033[0;32m"'/ /_/ / / / /  / / / / / / /_/ /    / /_(__  ) / / / '"\033[0m"
echo -e "\033[0;32m"'\____/_/ /_/  /_/ /_/ /_/\__, /    /___/____/_/ /_/  '"\033[0m"
echo -e "\033[0;32m"'                        /____/                       '"\033[0m"
echo -e "\033[0;34mHooray! Oh My Zsh has been updated and/or is at the current version.\033[0m"
echo -e "\033[0;34mTo keep up on the latest, be sure to follow Oh My Zsh on twitter: \033[1mhttp://twitter.com/ohmyzsh\033[0m"
