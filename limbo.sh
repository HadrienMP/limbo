#!/usr/bin/env bash

while(true);
 do
 echo "";
 echo "----";
 echo "Pull";
 echo "----";
 git pull --rebase;
 echo "----";
 echo "Push";
 echo "----";
 git push;
 done;
