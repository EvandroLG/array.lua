#!/usr/bin/env bash

if [ -n "$1" ]; then
  filename="array-$1-0.rockspec"
  touch $filename
  cat tasks/default_rockspec >> $filename
  sed -i '' "s/{version}/$1/g" $filename
else
  echo You should pass a new version
  exit 1
fi
