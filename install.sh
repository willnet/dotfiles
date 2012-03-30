#!/bin/sh

makelink()
{
if [ -e "$HOME/.$1" ]; then
  echo "already exists ~/.$1"
else
  echo "ln -s $PWD/`dirname $0`/$1 $HOME/.$1"
  ln -s "$PWD/`dirname $0`/$1" "$HOME/.$1"
fi  
}

makelink zshrc
makelink aliases
makelink pryrc
makelink gitconfig