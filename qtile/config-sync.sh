#!/bin/bash

SRC_DIR="$HOME"
DOT_DIR="$HOME/Downloads/my-linux-machine/qtile"

ITEMS=(
    "dunst"
    "kitty"
    "nvim"
    "picom"
    "qtile"
    "rofi"
    "starship.toml"
)

HOME_ITEMS=(
  ".zshrc"
  "config-sync.sh"
  ".vimrc"
  )

for ITEM in "${ITEMS[@]}"; do
    rsync -av "$SRC_DIR/.config/$ITEM" "$DOT_DIR/dotfiles/"
done

for ITEM in "${HOME_ITEMS[@]}"; do
    rsync -av "$SRC_DIR/$ITEM" "$DOT_DIR/"
done

echo "Sync complete!"

