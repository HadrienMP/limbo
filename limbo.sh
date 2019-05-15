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
			endspin;
		fi
	    spin
	elif [ $LOCAL = $BASE ]; then
		endspin
		echo "-----------------------------";
		echo "Pull";
		echo "-----------------------------";
		git pull --rebase;
		echo "-----------------------------";
		echo -e "\n"
	elif [ $REMOTE = $BASE ]; then
    	endspin;
		echo "-----------------------------";
		echo "Push";
		echo "-----------------------------";
		git push;
		echo "-----------------------------";
		echo -e "\n"
	else
		endspin
	    echo -en "\r\033[0;31mBEWARE ! No action possible, fix the divergence (possible rebase conflicts).\033[0m"
		conflictsToSolve=1
	fi
  done;
