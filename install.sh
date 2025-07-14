#!/bin/bash

BASHRC="$HOME/.bashrc"
ALIAS_SH="$(dirname "$0")/alias.sh"
GITCONFIG="$HOME/.gitconfig"
GITCONFIG_SH="$(dirname "$0")/gitconfig"

if [ -f "$ALIAS_SH" ]; then
  if ! grep -q '# alias.sh' "$BASHRC"; then
    cat "$ALIAS_SH" >> "$BASHRC"
  fi
fi

if [ -f "$GITCONFIG_SH" ]; then
  if ! grep -q '# gitconfig' "$GITCONFIG"; then
    echo "# gitconfig" >> "$GITCONFIG"
    cat "$GITCONFIG_SH" >> "$GITCONFIG"
  fi
fi
