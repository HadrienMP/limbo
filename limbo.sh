#!/usr/bin/env bash

while(true);
  do
  echo "";
  echo "----";
  echo "Pull";
  echo "----";
  git pull --rebase;

  if [[ $(git cherry) ]]; then
    echo "----";
    echo "Push";
    echo "----";
    git push;
  fi
  done;
