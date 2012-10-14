## Command history configuration
#
export HISTFILE=~/.zsh_history
export HISTSIZE=10000 # メモリ内の履歴の数
export SAVEHIST=10000 # 保存される履歴の数
setopt hist_ignore_dups # 同じコマンドを重複して記録しない
setopt share_history # share command history data

# ヒストリ呼び出しのカスタマイズ(http://gihyo.jp/dev/serial/01/zsh-book/0003)
bindkey '^p' history-beginning-search-backward # history-beginning-search-backward-endとは違い、カーソルは行末に移動しない
bindkey '^n' history-beginning-search-forward
