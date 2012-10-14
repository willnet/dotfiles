#!/bin/sh

cd `dirname $0`

DOTFILES=( zshrc aliases pryrc gitconfig railsrc tmux.conf gemrc)

makelink()
{
if [ -e "$HOME/.$1" ]; then
  echo "already exists ~/.$1"
else
  echo "ln -s `pwd`/$1 $HOME/.$1"
  ln -s "`pwd`/$1" "$HOME/.$1"
fi  
}

for((i = 0; i < ${#DOTFILES[*]}; i++))
{
  makelink "${DOTFILES[i]}"
}

# submodule 
echo "git submodule update --init"
git submodule update --init

#
# zsh
#
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

# zaw
if [ -e "$HOME/.zsh/zaw" ]; then
  echo "already exists ~/.zsh/zaw"
else
  echo "ln -s $PWD/zaw ~/.zsh/zaw"
  ln -s $PWD/zaw ~/.zsh/zaw
fi  
