#!/bin/zsh

# -e: exit on error
# -u: exit on unset variables
set -e

log_color() {
  color_code="$1"
  shift

  printf "\033[${color_code}m%s\033[0m\n" "$*" >&2
}

log_red() {
  log_color "0;31" "$@"
}

log_blue() {
  log_color "0;34" "$@"
}

log_task() {
  log_blue "🔃" "$@"
}

log_manual_action() {
  log_red "⚠️" "$@"
}

log_error() {
  log_red "❌" "$@"
}

error() {
  log_error "$@"
  exit 1
}

sudo() {
  if [ "$(id -u)" -eq 0 ]; then
    "$@"
  else
    if ! command sudo --non-interactive true 2>/dev/null; then
      log_manual_action "Root privileges are required, please enter your password below"
      command sudo --validate
    fi
    command sudo "$@"
  fi
}

script_path=${0:a:h}

# install stow if not found
if ! command -v stow >/dev/null 2>&1; then
  log_task "Installing stow"
  sudo apt update --yes
  sudo apt install stow --yes
fi
# install oh-my-posh
if ! command -v oh-my-posh >/dev/null 2>&1; then
  log_task "Installing oh-my-posh"
  curl -s https://ohmyposh.dev/install.sh | bash -s
fi
# install oh-my-zsh
dir="$HOME/.oh-my-zsh/"
if [ ! -d "$dir" ]; then
  log_task "Installing oh-my-zsh"
  sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
fi
cd $script_path
stow */