#!/usr/bin/env bash

if [ -n "$1" ]; then
  filename="array-$1-0.rockspec"
  key=$(cat .luarocks_key)
  luarocks upload $filename --api-key=$key
else
  echo You should pass a new version
  exit 1
fi
