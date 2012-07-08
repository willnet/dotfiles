export LANG=ja_JP.UTF-8
export EDITOR=emacsclient
export GREP_OPTIONS="--color=auto"

## Default shell configuration
#
# set prompt
#
autoload colors
colors
case ${UID} in
0)
    PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
dumb | emacs)
    PROMPT="%m:%~>"
    unsetopt zle
    ;;
*)
    PROMPT="%{${fg[red]}%}%/%%%{${reset_color}%} "
    PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
    SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
esac

## terminal configuration
#
unset LSCOLORS
case "${TERM}" in
xterm)
    export TERM=xterm-color
    ;;
kterm)
    export TERM=kterm-color
    # set BackSpace control character
    stty erase
    ;;
cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors \
        'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm*)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors \
        'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
esac

setopt auto_cd # cdを省略できる
setopt auto_pushd # cd -[tab]でcd履歴を参照。もちろん履歴の実行もできる。
setopt list_packed # 補完候補を詰めて表示する
setopt noautoremoveslash # パスの最後の/を自動的に削除しない
setopt nolistbeep # 補完候補表示時などのビープ音をオフ

## ディレクトリが変わったらディレクトリスタックを表示。
chpwd_functions=($chpwd_functions dirs)

# emacs like keybind
bindkey -e

# ヒストリ呼び出しのカスタマイズ(http://gihyo.jp/dev/serial/01/zsh-book/0003)
bindkey '^p' history-beginning-search-backward # history-beginning-search-backward-endとは違い、カーソルは行末に移動しない
bindkey '^n' history-beginning-search-forward

## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=10000 # メモリ内の履歴の数
SAVEHIST=10000 # 保存される履歴の数
setopt hist_ignore_dups # 同じコマンドを重複して記録しない
setopt share_history # share command history data

## Completion configuration
#
fpath=(~/.functions ${fpath})
autoload -U compinit
compinit

## zsh editor
#
autoload zed

if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

autoload zargs

if [ -f ~/.zsh/zaw/zaw.zsh ]; then
  source ~/.zsh/zaw/zaw.zsh
  bindkey '^R' zaw-history
fi

## prompt for git(http://d.hatena.ne.jp/uasi/20091025/1256458798)

autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

function rprompt-git-current-branch {
  local name st color gitdir action
  if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
    return
  fi
  name=`git branch 2> /dev/null | grep '^\*' | cut -b 3-`
  if [[ -z $name ]]; then
    return
  fi

  gitdir=`git rev-parse --git-dir 2> /dev/null`
  action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    color=%F{green}
  elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
    color=%F{yellow}
  elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
    color=%B%F{red}
  else
    color=%F{red}
  fi
  
  echo "$color$name$action%f%b"
}

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

# RPROMPT='[`rprompt-git-current-branch`%~]'
RPROMPT='[`rprompt-git-current-branch`]'


[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine

if [ -f ~/.zsh/z.sh ]; then
  _Z_CMD=j
  source ~/.zsh/z.sh
  precmd() {
    _z --add "$(pwd -P)"
  }
fi
