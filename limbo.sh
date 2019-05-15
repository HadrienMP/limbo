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

while(true);
  do
  	git remote update > /dev/null 2>&1;
	UPSTREAM=${1:-'@{u}'}
	LOCAL=$(git rev-parse @)
	REMOTE=$(git rev-parse "$UPSTREAM")
	BASE=$(git merge-base @ "$UPSTREAM")

	if [ $LOCAL = $REMOTE ]; then
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
	    echo "\033[0;31mBEWARE ! No action possible, fix the divergence (possible rebase conflicts)."
	fi
  done;
