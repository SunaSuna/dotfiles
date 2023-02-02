##### rbenv
eval "$(rbenv init -)"

##### starship
eval "$(starship init zsh)"

##### zinit
source $(brew --prefix)/opt/zinit/zinit.zsh
#
##### コマンド補完
zinit ice wait'0'; zinit light zsh-users/zsh-completions
autoload -Uz compinit && compinit

## 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

## 補完候補を一覧表示したとき、Tabや矢印で選択できるようにする
zstyle ':completion:*:default' menu select=1

#### シンタックスハイライト
zinit light zsh-users/zsh-syntax-highlighting

#### 履歴補完
zinit light zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"

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
alias ssh-okuru-admin-prd="AWS_DEFAULT_PROFILE=okuru ssh -i ~/.ssh/id_rsa_aws_access sunagawa@i-08287b95b478afe92"
alias ssh-okuru-sidekiq-prd="AWS_DEFAULT_PROFILE=okuru ssh -i ~/.ssh/id_rsa_aws_access sunagawa@i-045478382fad99a73"
alias ssh-okuru-batch-prd="AWS_DEFAULT_PROFILE=okuru ssh -i ~/.ssh/id_rsa_aws_access sunagawa@i-02c796002cc99de13"
alias ssh-pf-okuru-rds-prd="AWS_DEFAULT_PROFILE=okuru ssh -L 13306:okuru-production.c5d3yq3ae2lv.ap-northeast-1.rds.amazonaws.com:3306 -i ~/.ssh/id_rsa_aws_access sunagawa@i-02c796002cc99de13"
scp-okuru-batch-prd() {
  AWS_DEFAULT_PROFILE=okuru scp -i ~/.ssh/id_rsa_aws_access $1 sunagawa@i-02c796002cc99de13:~/
}
scp-okuru-admin-prd() {
  AWS_DEFAULT_PROFILE=okuru scp -i ~/.ssh/id_rsa_aws_access $1 sunagawa@i-08287b95b478afe92:~/
}
scp-to-local-okuru-admin-prd() {
  AWS_DEFAULT_PROFILE=okuru scp -i ~/.ssh/id_rsa_aws_access sunagawa@i-08287b95b478afe92:$1 $2
}

alias ssh-okuru-admin-stg="AWS_DEFAULT_PROFILE=okuru ssh -i ~/.ssh/id_rsa_aws_access sunagawa@i-0fdc2e058e84c59ef"
alias ssh-okuru-sidekiq-stg="AWS_DEFAULT_PROFILE=okuru ssh -i ~/.ssh/id_rsa_aws_access sunagawa@i-0bab496b47d2473d7"
alias ssh-okuru-batch-stg="AWS_DEFAULT_PROFILE=okuru ssh -i ~/.ssh/id_rsa_aws_access sunagawa@i-025adaaf5877fe7a7"
alias ssh-pf-okuru-rds-stg="AWS_DEFAULT_PROFILE=okuru ssh -L 13306:okuru-staging.c5d3yq3ae2lv.ap-northeast-1.rds.amazonaws.com:3306 -i ~/.ssh/id_rsa_aws_access sunagawa@i-0f0435467abfc2398"
scp-okuru-batch-stg() {
  AWS_DEFAULT_PROFILE=okuru scp -i ~/.ssh/id_rsa_aws_access $1 sunagawa@i-03d94bb18b1e77b2e:~/
}
scp-okuru-admin-stg() {
  AWS_DEFAULT_PROFILE=okuru scp -i ~/.ssh/id_rsa_aws_access $1 sunagawa@i-0fdc2e058e84c59ef:~/
}
scp-to-local-okuru-admin-stg() {
  AWS_DEFAULT_PROFILE=okuru scp -i ~/.ssh/id_rsa_aws_access sunagawa@i-0fdc2e058e84c59ef:$1 $2
}

alias ssh-mnenga-admin-prd="AWS_DEFAULT_PROFILE=mnenga ssh -i ~/.ssh/id_rsa_aws_access sunagawa@i-0e0db71546b3c4711"
alias ssh-mnenga-batch-prd="AWS_DEFAULT_PROFILE=mnenga ssh -i ~/.ssh/id_rsa_aws_access sunagawa@i-0c6d53c344dffacd2"
alias ssh-pf-mnenga-rds-prd="AWS_DEFAULT_PROFILE=mnenga ssh -L 13306:mitene-nenga-rds-production.cluster-ro-cajodrlbnjl5.ap-northeast-1.rds.amazonaws.com:3306 -i ~/.ssh/id_rsa_aws_access sunagawa@i-087437ad4f1c40c0b"
alias ssh-mnenga-admin-stg="AWS_DEFAULT_PROFILE=mnenga ssh -i ~/.ssh/id_rsa_aws_access sunagawa@i-0954bc7762e7d0c86"
alias ssh-mnenga-batch-stg="AWS_DEFAULT_PROFILE=mnenga ssh -i ~/.ssh/id_rsa_aws_access sunagawa@i-0c5682b6cc992a46f"
alias ssh-pf-mnenga-rds-stg="AWS_DEFAULT_PROFILE=mnenga ssh -L 13306:mitene-nenga-rds-stage.cluster-ro-cajodrlbnjl5.ap-northeast-1.rds.amazonaws.com:3306 -i ~/.ssh/id_rsa_aws_access sunagawa@i-0c5682b6cc992a46f"
alias ssh-mnenga-batch-itg="AWS_DEFAULT_PROFILE=mnenga ssh -i ~/.ssh/id_rsa_aws_access sunagawa@i-050133076d4bd19cc"
alias ssh-pf-mnenga-rds-itg="AWS_DEFAULT_PROFILE=mnenga ssh -L 13306:mitene-nenga-rds-integration.cluster-ro-cajodrlbnjl5.ap-northeast-1.rds.amazonaws.com:3306 -i ~/.ssh/id_rsa_aws_access sunagawa@i-050133076d4bd19cc"

alias ssh-master-user-app-prd="AWS_DEFAULT_PROFILE=mnenga ssh -i ~/.ssh/id_rsa_aws_access sunagawa@i-0680b569e841dbe7c"
alias ssh-pf-master-user-rds-prd="AWS_DEFAULT_PROFILE=mnenga ssh -L 13306:master-user-rds-production.cluster-ro-cajodrlbnjl5.ap-northeast-1.rds.amazonaws.com:3306 -i ~/.ssh/id_rsa_aws_access sunagawa@i-02eaa1795382d7ef9"
alias ssh-master-user-app-stg="AWS_DEFAULT_PROFILE=mnenga ssh -i ~/.ssh/id_rsa_aws_access sunagawa@i-0856ce80d44da46ee"
alias ssh-pf-master-user-rds-stg="AWS_DEFAULT_PROFILE=mnenga ssh -L 13306:master-user-rds-stage.cluster-ro-cajodrlbnjl5.ap-northeast-1.rds.amazonaws.com:3306 -i ~/.ssh/id_rsa_aws_access sunagawa@i-0856ce80d44da46ee"
alias ssh-master-user-app-itg="AWS_DEFAULT_PROFILE=mnenga ssh -i ~/.ssh/id_rsa_aws_access sunagawa@i-00cd8f68aacd06585"
alias ssh-pf-master-user-rds-itg="AWS_DEFAULT_PROFILE=mnenga ssh -L 13306:master-user-rds-integration.cluster-ro-cajodrlbnjl5.ap-northeast-1.rds.amazonaws.com:3306 -i ~/.ssh/id_rsa_aws_access sunagawa@i-00cd8f68aacd06585"
alias ssh-pf-fujifilm-factory="AWS_DEFAULT_PROFILE=mnenga ssh -L 10021:lpdo.fujifilmmall.jp:60990 -i ~/.ssh/id_rsa_aws_access sunagawa@i-0c6d53c344dffacd2"

alias ssh-pf-yearcara-rdsd-prd="AWS_DEFAULT_PROFILE=yearcard ssh -L 13306:yearcard-production.cdg8mqa1ctvv.ap-northeast-1.rds.amazonaws.com:3306 -i ~/.ssh/id_rsa_aws_access sunagawa@i-036a01838b4701e37"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PATH"
eval "$(pyenv init -)"
