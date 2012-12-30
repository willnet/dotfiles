## Alias configuration
#
# expand aliases before completing
#

setopt complete_aliases     # 自動補完時にaliasを展開する

alias where="command -v"
alias g="git"
alias r="rails"
alias rg="rails g"
alias rgc="rails g controller"
alias rgm="rails g model"
alias rgi="rails g integration_test"
alias rc="rails c"
alias e="emacsclient"
alias b="bundle"
alias be="bundle exec"
autoload -Uz zmv
alias zmv='noglob zmv -W'
alias pd=popd
alias psg='ps aux | grep'
alias -g G='| grep'
alias dm="rake db:migrate"
alias dmr="rake db:migrate:reset"
alias ds="rake db:seed"
alias -g RET="RAILS_ENV=test"
alias -g RED="RAILS_ENV=development"
alias -g RES="RAILS_ENV=staging"
alias -g REP="RAILS_ENV=production"

case "${OSTYPE}" in
freebsd*|darwin*)
    alias ls="ls -G -w"
    ;;
linux*)
    alias ls="ls --color"
    ;;
esac

alias la="ls -a"
alias lf="ls -F"
alias ll="ls -la"
alias du="du -h"
alias df="df -h"
alias su="su -l"
alias j="_z"
if [ -x `which rlwrap 2> /dev/null` ]; then  
  alias c="rlwrap coffee"
  alias coffee="rlwrap coffee"
fi
