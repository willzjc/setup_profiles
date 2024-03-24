# Misc

alias wget="wget --no-check-certificate"
alias cdg='cd ~/git'
alias cdw='cd ~/workspace'

# quickly creates a new folder with today's date

function cdtd {
	DATESTR=$(date +%Y%m%d)
	mkdir -p $HOME/text/$DATESTR
	cd $HOME/text/$DATESTR
	ln -sfn $HOME/text/$DATESTR ~/text/today
}

function td {
 DATESTR=$(date +%Y%m%d)
 if [ ! -d "$HOME/text/$DATESTR" ] ; then
  PREV_LINK=$(readlink -f ~/text/today)
  mkdir -p $HOME/text/$DATESTR
  if [ ! -z $PREV_LINK ] ; then
   ln -sfn $PREV_LINK $HOME/text/$DATESTR/previous	# Captures previous workspace and points it as 'previous'
   ln -sfn $PREV_LINK $HOME/text/previous	
  fi
 fi

 if [ ! -d "$HOME/text/logs" ] ; then
  mkdir -p $HOME/text/logs
 fi

 # HISTORY=$(date +%Y%m%d-%H%M%S)

 if [ ! -f $HOME/text/logs/cmd_history.$DATESTR.log ] ; then
  history > $HOME/text/logs/cmd_history.$DATESTR.log
  cp $HOME/.zsh_history $HOME/text/logs/zsh_history.$DATESTR.log
 fi

 ln -sfn $HOME/text/$DATESTR $HOME/text/today
 ln -sfn $HOME/text/$DATESTR $HOME/text/current

 cd $HOME/text/today
}

function qgit {
	DATESTR=$(date +%Y%m%d\ %H:%M)	
	git add .
	git commit -m "$DATESTR| $1"
	#git push --set-upstream origin master	# No longer used, using git config --global push.default current instead
	git push
}

for extrasource in '~/.sourceprofile/aws.sh'; do
{
 if [ -f $extrasource ] ; then
 {
  source "$extrasource"
 }
 fi
}
done

if [ $(uname -s) = "Darwin" ] ; then
{
 source ~/.sourceprofile/osx.sh
}
fi

