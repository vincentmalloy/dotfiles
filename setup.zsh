#!/bin/zsh

# -e: exit on error
# -u: exit on unset variables
set -eu

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

# install xstow if not found
if ! command -v xstow >/dev/null 2>&1; then
  log_task "Installing xstow"
  sudo apt update --yes
  sudo apt install xstow --yes
fi
# install oh-my-posh
if ! command -v oh-my-posh >/dev/null 2>&1; then
  log_task "Installing oh-my-posh"
  curl -s https://ohmyposh.dev/install.sh | bash -s
  log_task "Installing nerd Font"
  oh-my-posh font install RobotoMono
fi
# install thefuck
if ! command -v thefuck >/dev/null 2>&1; then
  log_task "Installing thefuck"
  sudo apt update --yes
  sudo apt install python3-dev python3-pip python3-setuptools
  pip3 install thefuck --user
fi
# install oh-my-zsh
dir="$HOME/.oh-my-zsh/"
if [ ! -d "$dir" ]; then
  log_task "Installing oh-my-zsh"
  sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended
fi
dir="$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/"
# install zsh autosuggestions
if [ ! -d "$dir" ]; then
  log_task "Installing zsh autosuggestions"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
cd $script_path
#create local git config if it does not exist
if [ ! -f "./git/.gitconfig.local" ]; then
  log_task "setting up git"
  log_manual_action "please enter your full name:"
  vared -p '' -c name
  log_manual_action "please enter your email adress:"
  vared -p '' -c email
  export name="$name"
  export email="$email"
  envsubst < gitconfig.local.template > git/.gitconfig.local
fi
# stow actual dotfiles
xstow --restow */