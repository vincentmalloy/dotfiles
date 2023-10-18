# git shorthand
# No arguments: `git status`
# With arguments: acts like `git`
g() {
  if [[ $# -gt 0 ]]; then
    git "$@"
  else
    git status -sb
  fi
}
# From Dan Ryan's blog - http://danryan.co/using-antigen-for-zsh.html
man () {
  # Shows pretty `man` page.
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;32;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
      man "$@"
}

# flush typo3 cache in ddev project
flush () {
  # get installed version of typo3/cms-core
  composer_version=`ddev composer show 'typo3/cms-core' | sed -n '/versions/s/^[^0-9]\+\([^,]\+\).*$/\1/p' | cut -d '.' -f1`
  # if composer_version > 11, use typo3, else use typo3cms
  if [ $composer_version -gt 11 ]; then
    ddev typo3 cache:flush
  else
    ddev typo3cms cache:flush
  fi
  echo "wiped typo3 cache"
}