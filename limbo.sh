#!/usr/bin/env bash

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
  if ! [[ $(git status --porcelain) ]]; then
    git pull --rebase --quiet;
    pullSpin;
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
    echo -n "\n\n"
  fi
  done;
