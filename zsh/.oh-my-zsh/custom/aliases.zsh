alias l="exa --color=always --group-directories-first --icons"
alias ll="exa --color=always --group-directories-first --icons -lah --no-permissions --no-time --no-user"
alias lll="exa --color=always --group-directories-first --icons -lah --accessed --modified --created --links --classify --group"
alias mkdir="mkdir -pv"
alias ping="ping -c 5"
alias c="clear"
alias wttr="curl wttr.in\?format\=3"
alias dotfiles="$EDITOR ~/.dotfiles/"
alias ffs="sudo !!"
alias update="sudo apt update && sudo apt upgrade -y"
alias countfiles="find . ! -name . -prune -print | grep -c /"
alias e="explorer.exe ." # Open current directory in Windows Explorer
#ddev
alias t3="ddev typo3cms"
#replace code-insiders with code
alias code="code-insiders"
# replace cat with bat
alias cat="batcat"
# Copy public key to clipboard:
alias pubkey="cat ~/.ssh/id_rsa.pub | clipcopy | echo '=> Public key copied to clipboard.'"