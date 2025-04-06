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


gittree() {
  # Get only the files changed in the latest commit
  local changed_files=$(git diff-tree --no-commit-id --name-only -r HEAD)

  # Check if any files were changed
  if [ -z "$changed_files" ]; then
    echo "No files were changed in the latest commit."
    return 0
  fi

  # Check if tree command is available
  if command -v tree &> /dev/null; then
    # Create a temporary file to store the list of changed files
    local temp_file=$(mktemp)
    
    # Write each changed file path to the temp file
    echo "$changed_files" > "$temp_file"
    
    echo "Files changed in the latest commit:"
    # Use tree command with fromfile option to show the actual structure without temp directory in the output
    tree --fromfile "$temp_file"
    
    # Clean up
    rm "$temp_file"
  else
    # Fallback if tree command is not available
    echo "Files changed in the latest commit:"
    echo "$changed_files" | sort | sed 's/^/├── /'
    echo "└── (Install 'tree' command for better visualization)"
  fi
}


# Detect if running under WSL
if grep -qi microsoft /proc/version; then
  export BROWSER="wslview"
  export LIBGL_ALWAYS_SOFTWARE=1
fi


