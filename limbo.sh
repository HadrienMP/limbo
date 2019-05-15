#!/usr/bin/env bash

while(true);
  do
  if ! [[ $(git status --porcelain) ]]; then
  echo "----";
  echo "Pull";
  echo "----";
  git pull --rebase;
  fi

  if [[ $(git cherry) ]]; then
    echo "----";
    echo "Push";
    echo "----";
    git push;
  fi
  done;
