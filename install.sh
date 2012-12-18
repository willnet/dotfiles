#!/bin/sh

cd `dirname $0`

DOTFILES=( zshrc aliases pryrc gitconfig railsrc tmux.conf gemrc )

check_exists()
{
if [ -e $1 ]; then
  echo "already exists $1"
  return 1
else
  return 0
fi
}

makelink()
{
check_exists $2 && echo "ln -s $1 $2" && ln -s $1 $2
}

for DOTFILE_PATH in $DOTFILES; do
  makelink "`pwd`/$DOTFILE_PATH" "$HOME/.$DOTFILE_PATH"
done

# submodule 
echo "git submodule update --init"
git submodule update --init

check_exists ~/.zsh && mkdir ~/.zsh
check_exists ~/.zsh/z.sh && makelink "`pwd`/z/z.sh" "$HOME/.zsh/z.sh"
check_exists ~/.zsh/zaw && makelink "`pwd`/zaw" "$HOME/.zsh/zaw"

