function nvimide() {
  USAGE="Usage: nvimide delete"

  if [[ $# -eq 1 ]]; then
    if [[ "$1" == "delete" ]]; then
      echo "Deleting local Neovim files..."
      rm -rf ~/.config/nvim
      rm -rf ~/.local/share/nvim
      echo "Local Neovim files have been deleted."
    else
      echo "Invalid argument. $USAGE"
    fi
  else
    echo "$USAGE"
  fi
}

