#!/bin/sh

makelink()
{
if [ -e "$HOME/$0" ]; then
  echo "already exists $0"
else
  echo "ln -s $PWD/`dirname $0`/$1 $HOME/.$1"
  ln -s "$PWD/`dirname $0`/$1" "$HOME/.$1"
fi  
}

makelink zshrc
makelink aliases
makelink pryrc
makelink gitconfig