# 少し凝った zshrc
# License : MIT
# http://mollifier.mit-license.org/

########################################
# 環境変数
export PATH=/usr/local/bin:$PATH
export LANG=ja_JP.UTF-8

# 色を使用出来るようにする
autoload -Uz colors
colors

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# 補完
# 補完機能を有効にする

# 補完ロード
if [ -e ~/.zsh/completions ]; then
  fpath=(~/.zsh/completions $fpath)
fi

if [ -e ~/.zsh/zsh-completions/src ]; then
  fpath=(~/.zsh/zsh-completions/src $fpath)
fi

if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

autoload -U compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

########################################
# キーバインド

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

########################################
# エイリアス

alias la='ls -a'
alias ll='ls -l'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

# ------------------------------------
# Docker aliases
# ------------------------------------

alias d="docker"

# Get the latest container ID
alias dl="docker ps --latest --quiet"

# List containers
alias dps="docker ps"

# List containers including stopped containers
alias dpa="docker ps --all"

# List images
alias di="docker images"

# List images including intermediates
alias dia="docker images --all"

# Tree images including intermediates
alias dit="docker images --tree"

# Get an IPaddress of a container
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Run a daemonized container
alias drd="docker run --detach --publish-all"

# Run an interactive container
alias dri="docker run --interactive --tty --publish-all"

# Remove all containers
alias drm='docker rm $(docker ps --all --quiet)'

# Remove all images
alias drmi='docker rmi $(docker images --quiet)'

# Remove all containers and images by force
alias dclean='docker kill $(docker ps --all --quiet); drm; drmi;'

# List all aliases relating to docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)='\(.*\)'/\1    => \2/"| sed "s/'\\\'//g"; }

alias dc='docker-compose'

# ruby alias
alias be='bundle exec'

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi


########################################
# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F --color=auto'
        ;;
    linux*)
        #Linux用の設定
        alias ls='ls -F --color=auto'
        ;;
esac

# typeset
#  -U 重複パスを登録しない
#  -x exportも同時に行う
#  -T 環境変数へ紐付け
#
# path=xxxx(N-/)
#   (N-/): 存在しないディレクトリは登録しない
#   パス(...): ...という条件にマッチするパスのみ残す
#      N: NULL_GLOBオプションを設定。
#         globがマッチしなかったり存在しないパスを無視する
#      -: シンボリックリンク先のパスを評価
#      /: ディレクトリのみ残す
#      .: 通常のファイルのみ残す

## 重複パスを登録しない
typeset -U path cdpath fpath manpath

## sudo用のpathを設定
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({/usr/local,/usr,}/sbin(N-/))

## pathを設定
path=(~/bin(N-/) /usr/local/bin(N-/) ${path})


eval "$(hub alias -s)"

## setting for go
export GO111MODULE=on

export PATH=$HOME/bin:$PATH

## setting for anyenv
export ANYENV_ROOT="${HOME}/.anyenv"
if [ -d $ANYENV_ROOT ]; then
  export PATH="$ANYENV_ROOT/bin:$PATH"
  for D in `command ls $ANYENV_ROOT/envs`
  do
    export PATH="$ANYENV_ROOT/envs/$D/shims:$PATH"
  done
fi

eval "$(anyenv init -)"
export PATH="$PATH:`yarn global bin`"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

export EDITOR="vim"
export PATH="${HOME}/bin:$PATH"
alias sudo='sudo -E'

