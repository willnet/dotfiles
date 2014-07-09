export LANG=ja_JP.UTF-8
export EDITOR=emacsclient
export GREP_OPTIONS="--color=auto"
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

setopt auto_cd # cdを省略できる
setopt auto_pushd # cd -[tab]でcd履歴を参照。もちろん履歴の実行もできる。
setopt list_packed # 補完候補を詰めて表示する
setopt noautoremoveslash # パスの最後の/を自動的に削除しない
setopt nolistbeep # 補完候補表示時などのビープ音をオフ

## ディレクトリが変わったらディレクトリスタックを表示。
# chpwd_functions=($chpwd_functions dirs)

# emacs like keybind
bindkey -e

autoload zargs

if [ -f ~/.zsh/zaw/zaw.zsh ]; then
  source ~/.zsh/zaw/zaw.zsh
  bindkey '^R' zaw-history
fi

if [ -f ~/.zsh/z.sh ]; then
  _Z_CMD=j
  source ~/.zsh/z.sh
  precmd() {
    _z --add "$(pwd -P)"
  }
fi

ZSHHOME="${HOME}/.zsh"

if [ -d $ZSHHOME -a -r $ZSHHOME -a -x $ZSHHOME ]; then
    for i in $ZSHHOME/*; do
        [[ ${i##*/} = *.zsh ]] &&
            [ \( -f $i -o -h $i \) -a -r $i ] && . $i
    done
fi
