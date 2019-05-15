#!/usr/bin/env bash

while(true);
  do
  if ! [[ $(git status --porcelain) ]]; then
  echo "----";
  echo "Pull";
  echo "----";
  git pull --rebase --quiet;
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
