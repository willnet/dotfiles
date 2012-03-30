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

# submodule 
cd "$PWD/`dirname $0`"
git submodule update --init

if [ -e "$HOME/.zsh" ]; then
  echo "already exists .zsh"
else
  mkdir ~/.zsh
fi

if [ -e "$HOME/.zsh/z.sh" ]; then
  echo "already exists ~/.zsh/z.sh"
else
  echo "ln -s $PWD/z/z.sh ~/.zsh/z.sh"
  ln -s $PWD/z/z.sh ~/.zsh/z.sh
fi  

