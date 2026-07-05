#!/bin/sh

declare -a dependencies=(
  "tree-sitter-cli"
)

for i in "${dependencies[@]}"
do
  echo "Installing $i"
  pnpm i -g $i  
done
  
echo "Installed all dependencies!"

