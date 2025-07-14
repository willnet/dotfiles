#!/bin/bash

BASHRC="$HOME/.bashrc"
ALIAS_SH="$(dirname "$0")/alias.sh"
GITCONFIG_DEST="$HOME/.config/git/config"
GITCONFIG_SOURCE="$(dirname "$0")/gitconfig"

if [ -f "$ALIAS_SH" ]; then
  if ! grep -q '# alias.sh' "$BASHRC"; then
    cat "$ALIAS_SH" >> "$BASHRC"
  fi
fi

if [ -f "$GITCONFIG_SOURCE" ]; then
  mkdir -p "$(dirname "$GITCONFIG_DEST")"
  if ! grep -q '# gitconfig' "$GITCONFIG_DEST"; then
    echo "# gitconfig" >> "$GITCONFIG_DEST"
    cat "$GITCONFIG_SOURCE" >> "$GITCONFIG_DEST"
  fi
fi
