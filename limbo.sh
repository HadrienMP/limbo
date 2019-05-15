#!/usr/bin/env bash

sp='/-\|'
sc=0
spin() {
    echo -n "Pulling ${sp:sc++:1}"
    ((sc==${#sp})) && sc=0
}
endspin() {
    printf '\r%s\n' "$@"
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
    endspin;
    echo "----";
    echo "Push";
    echo "----";
    git push;
  fi
  done;
