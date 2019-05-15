#!/usr/bin/env bash

sp='/-\|'
sc=0
spin() {
    printf "\b${sp:sc++:1}"
    ((sc==${#sp})) && sc=0
    sleep 0.1
}
endspin() {
    printf '\r%s\n' "$@"
    sleep 0.1
}

while(true);
  do
  if ! [[ $(git status --porcelain) ]]; then
    git pull --rebase --quiet;
    spin;
  fi

  if test -d ".git/rebase-apply" ; then
     echo "i\033[0;31mPlease deal with rebase conflicts !!!";
  fi

  if [[ $(git cherry) ]]; then
    echo "----";
    echo "Push";
    echo "----";
    git push;
  fi
  done;
