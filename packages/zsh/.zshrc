##### rbenv
eval "$(rbenv init -)"

##### starship
eval "$(starship init zsh)"

## 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

## 補完候補を一覧表示したとき、Tabや矢印で選択できるようにする
zstyle ':completion:*:default' menu select=1

#### peco
## コマンド履歴検索
function peco-history-selection() {
  BUFFER=`history -n 1 | tac  | awk '!a[$0]++' | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N peco-history-selection
bindkey '^F' peco-history-selection

#### zsh
## 履歴保存管理
HISTFILE=$ZDOTDIR/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

## 他のzshと履歴を共有
setopt inc_append_history
setopt share_history

## パスを直接入力してもcdする
setopt AUTO_CD

## 環境変数を補完
setopt AUTO_PARAM_KEYS

# alias
alias ls="gls --color=auto"
alias la="gls --color=auto -la"
alias ll="gls --color=auto -l"
alias cp="cp -i"
alias rm='rm -i'
alias mv='mv -i'
alias v="vim"
alias be="bundle exec"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

##### コマンド補完
zinit ice wait'0'; zinit light zsh-users/zsh-completions
autoload -Uz compinit && compinit

#### シンタックスハイライト
zinit light zsh-users/zsh-syntax-highlighting

#### 履歴補完
zinit light zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"

#### mysql
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"

#### dotfile bin
export DOTFILE_BIN_ROOT="$HOME/dotfiles_bin"
export PATH="$DOTFILE_BIN_ROOT/:$PATH"

#### openssl
export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"

### mise
eval "$(mise env)"
eval "$(mise activate bash)"

############## Android
export ANDROID_SDK_ROOT=~/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/tools/bin:$ANDROID_SDK_ROOT/platform-tools

############## AWS
alias aws-r-okuru-dev='eval $(assume-role okuru-itg)'
alias aws-r-okuru='eval $(assume-role okuru)'

############## ECS
ecs-exec-command() {
    # Check if the right number of arguments are passed
    if [ $# -ne 3 ]; then
        echo "Usage: ecs_exec_command <cluster> <container> <service>"
        return 1
    fi

    # Get the parameters
    cluster=$1
    container=$2
    service=$3

    # Command to execute
    command="/bin/sh"

    # Get the list of task ARNs for the service
    taskArns=$(aws ecs list-tasks --cluster $cluster --service-name $service --query 'taskArns' --output text)

    # If there are no tasks, exit
    if [ -z "$taskArns" ]; then
        echo "No tasks found for service $service in cluster $cluster"
        return 1
    fi

    # Get the first task ARN
    taskArn=$(echo $taskArns | awk '{print $1}')

    # Get the task ID from the task ARN
    taskId=${taskArn##*/}

    # Execute command on the task
    aws ecs execute-command \
    --cluster $cluster \
    --container $container \
    --interactive \
    --command "$command" \
    --task $taskId
}
alias ecs-exec-to-admin-itg="aws-r-okuru-dev; ecs-exec-command okuru-integration app okuru-itg-admin"
alias ecs-exec-to-admin-prod="aws-r-okuru; ecs-exec-command okuru-production app okuru-prod-admin"

ssm-port-forwarding() {
    # Check if the right number of arguments are passed
    if [ $# -ne 4 ]; then
      echo "Usage: ecs_exec_command <cluster> <container> <service> <rds_host>"
      return 1
    fi

    # Get the parameters
    cluster=$1
    container=$2
    service=$3
    rds_host=$4

    # Get the list of task ARNs for the service
    taskArns=$(aws ecs list-tasks --cluster $cluster --service-name $service --query 'taskArns' --output text)

    # If there are no tasks, exit
    if [ -z "$taskArns" ]; then
      echo "No tasks found for service $service in cluster $cluster"
      return 1
    fi

    # Get the first task ARN
    taskArn=$(echo $taskArns | awk '{print $1}')

    # Get the task ID from the task ARN
    taskId=${taskArn##*/}

    runtime_id=$(aws ecs describe-tasks --cluster $cluster --task $taskId | jq -r --arg CONTAINER_NAME $container '.tasks[0].containers[] | select(.name == $CONTAINER_NAME).runtimeId')
    target=$(echo "ecs:${cluster}_${taskId}_${runtime_id}")

    echo "target..... ${target}"

    paramaters="{\"host\":[\"${rds_host}\"],\"portNumber\":[\"3306\"],\"localPortNumber\":[\"13306\"]}"

    # コンテナへのポートフォワーディング開始
    aws ssm start-session \
      --target $target \
      --document-name AWS-StartPortForwardingSessionToRemoteHost \
      --parameters $paramaters
}
alias pf-itg-admin-rds="aws-r-okuru-dev; ssm-port-forwarding okuru-integration app okuru-itg-admin okuru-integration.c1brow9f43u1.ap-northeast-1.rds.amazonaws.com"
alias pf-prod-admin-rds="aws-r-okuru; ssm-port-forwarding okuru-production app okuru-prod-admin okuru-production.c5d3yq3ae2lv.ap-northeast-1.rds.amazonaws.com"
