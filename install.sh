#!/bin/sh

if [ -e "$HOME/.zshrc" ]; then
  echo "already exists .zshrc"
else
  echo "ln -s $PWD/`dirname $0`/zshrc $HOME/.zshrc"
  ln -s "$PWD/`dirname $0`/zshrc" "$HOME/.zshrc"
fi

if [ -e "$HOME/.aliases" ]; then
  echo "already exists .aliases"
else
  echo "ln -s $PWD/`dirname $0`/aliases $HOME/.aliases"
  ln -s "$PWD/`dirname $0`/aliases" "$HOME/.aliases"
fi

if [ -e "$HOME/.pryrc" ]; then
  echo "already exists .pryrc"
else
  echo "ln -s $PWD/`dirname $0`/pryrc $HOME/.pryrc"
  ln -s "$PWD/`dirname $0`/pryrc" "$HOME/.pryrc"
fi