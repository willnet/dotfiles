#!/bin/bash

BASHRC="$HOME/.bashrc"
ALIAS_SH="$(dirname "$0")/alias.sh"

if [ -f "$ALIAS_SH" ]; then
  if ! grep -q '# alias.sh' "$BASHRC"; then
    cat "$ALIAS_SH" >> "$BASHRC"
  fi
fi
