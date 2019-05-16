#!/usr/bin/env bash

# ------------
# Pull Spinner
# ------------
sp='/-\|'
sc=0
spin() {
    echo -en "\rWaiting for change ${sp:sc++:1}"
    ((sc==${#sp})) && sc=0
}
endspin() {
    printf '\r%s\n' "$@"
}

waitingForChange=0
conflictsToSolve=0

while(true);
  do
  	git remote update &> /dev/null;
	UPSTREAM=${1:-'@{u}'}
	LOCAL=$(git rev-parse @)
	REMOTE=$(git rev-parse "$UPSTREAM")
	BASE=$(git merge-base @ "$UPSTREAM")

	if [ $LOCAL = $REMOTE ]; then
		if [ $conflictsToSolve -eq 1 ]; then
			conflictsToSolve=0
		fi
	    spin
	    waitingForChange=1
	elif [ $LOCAL = $BASE ]; then
		if [ $conflictsToSolve -eq 1 ]; then
			conflictsToSolve=0
		fi
		if [ $waitingForChange -eq 1 ]; then
			waitingForChange=0
			endspin
		fi
		echo "-----------------------------";
		echo "Pull";
		echo "-----------------------------";
		git pull --rebase;
		echo "-----------------------------";
		echo -e "\n"
	elif [ $REMOTE = $BASE ]; then
		if [ $conflictsToSolve -eq 1 ]; then
			conflictsToSolve=0
		fi
		if [ $waitingForChange -eq 1 ]; then
			waitingForChange=0
    		endspin;
		fi
		echo "-----------------------------";
		echo "Push";
		echo "-----------------------------";
		git push;
		echo "-----------------------------";
		echo -e "\n"
	else
		if [ $waitingForChange -eq 1 ]; then
			waitingForChange=0
			endspin
		fi
		if [ $conflictsToSolve -eq 0 ]; then
		    echo -e "\033[0;31mBEWARE ! No action possible, fix the divergence (possible rebase conflicts).\033[0m"
		    read -p "Would like to reset your local copy to match the remote one ? (y/N) " reset
		    if [[ reset -eq "y" ]]; then
				remoteBranch= `git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/@@'`
				git reset --hard $remoteBranch
		    fi
			conflictsToSolve=1
		fi
	fi
  done;

