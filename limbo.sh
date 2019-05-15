#!/usr/bin/env bash


# ------------
# Pull
# ------------
pull() {
  if ! [[ $(git status --porcelain) ]]; then
    git pull --rebase --quiet;
    pullSpin;
  fi

  if test -d ".git/rebase-apply" ; then
     echo "i\033[0;31mPlease deal with rebase conflicts !!!";
  fi
}

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
pullSpin() {
    echo -en "\rPulling ${sp:sc++:1}"
    ((sc==${#sp})) && sc=0
}
endspin() {
    printf '\r%s\n' "$@"
}

while(true);
  do
  	pull;
  	push;
  done;
