#!/usr/bin/env bash


# ------------
# Pull
# ------------

# ------------
# Push
# ------------
push() {
  if [[ $(git cherry) ]]; then
    endspin;
    echo "-----------------------------";
    echo "Push";
    echo "-----------------------------";
    git push;
    echo "-----------------------------";
    echo -e "\n"
  fi
}
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
  	git remote update > /dev/null;
	UPSTREAM=${1:-'@{u}'}
	LOCAL=$(git rev-parse @)
	REMOTE=$(git rev-parse "$UPSTREAM")
	BASE=$(git merge-base @ "$UPSTREAM")

	if [ $LOCAL = $REMOTE ]; then
	    spin
	elif [ $LOCAL = $BASE ]; then
		endspin
		git pull --rebase;
	elif [ $REMOTE = $BASE ]; then
  		push;	
	else
	    echo "\033[0;31mBEWARE ! No action possible, fix the divergence (possible rebase conflicts)."
	fi
  done;
