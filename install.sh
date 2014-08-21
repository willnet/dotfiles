#!/bin/sh

cd `dirname $0`

DOTFILES=("zshrc" "pryrc" "gitconfig" "railsrc" "tmux.conf" "gemrc" "irbrc")

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

for DOTFILE_PATH in ${DOTFILES[@]}; do
  makelink "`pwd`/$DOTFILE_PATH" "$HOME/.$DOTFILE_PATH"
done

# submodule
echo "git submodule update --init"
git submodule update --init

check_exists ~/.zsh && mkdir ~/.zsh
check_exists ~/.zsh/z.sh && makelink "`pwd`/z/z.sh" "$HOME/.zsh/z.sh"
check_exists ~/.zsh/zaw && makelink "`pwd`/zaw" "$HOME/.zsh/zaw"
check_exists ~/.zsh/aliases.zsh && makelink "`pwd`/zsh/aliases.zsh" "$HOME/.zsh/aliases.zsh"
check_exists ~/.zsh/completion.zsh && makelink "`pwd`/zsh/completion.zsh" "$HOME/.zsh/completion.zsh"
check_exists ~/.zsh/history.zsh && makelink "`pwd`/zsh/history.zsh" "$HOME/.zsh/history.zsh"
check_exists ~/.zsh/prompt.zsh && makelink "`pwd`/zsh/prompt.zsh" "$HOME/.zsh/prompt.zsh"
