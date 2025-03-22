# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# Personal Configuration
HISTSIZE=-1
HISTFILESIZE=-1
HISTTIMEFORMAT='%F %T '
PROMPT_HISTORY='history -a'

shopt -s autocd
shopt -s cdspell
shopt -s checkwinsize
shopt -s dirspell

alias bashrc='vim ~/.bashrc'
alias check-ech='curl -s https://crypto.cloudflare.com/cdn-cgi/trace/'
alias diff='diff --color'
#alias empty-trash='rm -rf ~/.local/share/Trash'
alias fuzzer='fzf --preview "bat --color=always --style=numbers --line-range=50 {}"'
alias kube-config='vim ~/.kube/config'
alias ll='ls -lA'
alias nvim-config='nvim ~/.config/nvim/init.lua'
alias sing='update_singbox_config && sudo sing-box run -D /tmp/sing-box/ -c /etc/sing-box/config.json'
alias skrg='sk -i -c "rg {} --color=always" --ansi'
alias ssh-config='vim ~/.ssh/config'
alias tmux-main='tmux new-session -s MAIN || tmux attach-session -t MAIN'
alias top=htop
alias tor-browser='cd /opt/tor-browser/ && ./start-tor-browser.desktop && cd ~'
alias tor='if [ $(stat -c %g /run/tor/) != ${GROUPS} ] || [ $(stat -c %u /run/tor/) != ${UID} ] ; then sudo chown ${USER}:${USER} /run/tor/ && tor ; else tor ; fi'
alias tshark='tshark --color'
alias vim='vim -p'
alias vimrc='vim ~/.vimrc'
alias whatismyasn='curl -sfL myadd.ir/asnfull ; echo'
alias whatismyip='curl -sfL myadd.ir/ip ; echo'
alias wireguard_keys='wg keygen | tee privatekey | wg pubkey > publickey'

# Confirmation + Verbose
alias cp='cp -iv'
alias ln='ln -iv'
alias mkdir='mkdir -pv'
alias mv='mv -iv'
alias rm='rm -iv'

# $PATH modifications for bcc
export PATH=$PATH:/usr/share/bcc/tools

# EDITOR
EDITOR=/usr/bin/vim

# User specific environment and startup programs
. "$HOME/.cargo/env"

# LESS Variables
export LESS="--tabs=4 --hilite-unread --ignore-case --long-prompt --mouse --line-numbers --quit-if-one-screen --hilite-search --shift=5 --tabs=4" # --chop-long-lines -S

# add Pulumi to the PATH
# export PATH=$PATH:/home/optimusprime/.pulumi/bin

# add Terraform completion to the shell
complete -C /usr/bin/terraform terraform

function updateyq() {
  readonly URL="https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64"
  readonly TMPDIR=$(mktemp -d)
  trap "rm -rf $TMPDIR" EXIT

  cd $TMPDIR

  curl -fsSL -o yq ${URL}
  sudo rm -f /usr/local/bin/yq
  sudo mv yq /usr/local/bin/yq
  sudo chmod +x /usr/local/bin/yq
  /usr/local/bin/yq shell-completion bash | sudo tee /etc/bash_completion.d/yq
  cd "$HOME"

  yq --version
}

function update_completions() {
# gh completion -s bash | sudo tee /etc/bash_completion.d/gh
  helm completion bash | sudo tee /etc/bash_completion.d/helm
# k9s completion bash | sudo tee /etc/bash_completion.d/k9s
  kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl
  pip3 completion --bash | sudo tee /etc/bash_completion.d/pip3
  podman completion bash | sudo tee /etc/bash_completion.d/podman
# pulumi gen-completion bash | sudo tee /etc/bash_completion.d/pulumi
  retis sh-complete --shell bash | sudo tee /etc/bash_completion.d/retis
  rg --generate=complete-bash | sudo tee /etc/bash_completion.d/ripgrep
  rustup completions bash cargo | sudo tee /etc/bash_completion.d/cargo
  rustup completions bash | sudo tee /etc/bash_completion.d/rustup
  sing-box completion bash | sudo tee /etc/bash_completion.d/sing-box
  tldr --print-completion bash | sudo tee /etc/bash_completion.d/tldr
}

function update_singbox_config() {
  readonly URL=""
  readonly TMPDIR=$(mktemp -d)
  readonly USERAGENT="$(echo -n "SFM/$(sing-box version | grep version | gawk '{print $3}')")"
  trap "rm -rf $TMPDIR" EXIT

  cd $TMPDIR

  # Check if the config.json exists
  if [ ! -f /etc/sing-box/config.json ]; then
    echo "Config file doesn't exist, downloading..."
    wget -q --tries=0 --wait=5 --random-wait --user-agent="${USERAGENT}" "${URL}" -O config.json
    sudo mv config.json /etc/sing-box/config.json

  # Check if the config.json modified time is more than 12 hours
  elif [ -f /etc/sing-box/config.json ] && [ $(find /etc/sing-box/config.json -mmin +720) ]; then
    echo "Config file is older than 12 hours, updating..."
    wget -q --tries=0 --wait=5 --random-wait --user-agent="${USERAGENT}" "${URL}" -O config.json
    sudo mv -f config.json /etc/sing-box/config.json
  fi

  cd "$HOME"
  mkdir -p /tmp/sing-box
  sing-box check -c /etc/sing-box/config.json
}

function get_kernel_changelog() {
  if [ $# -ne 1 ]
  then
    echo "Usage: get_kernel_changelog <changelog_url from kernel.org>"
    return 1
  fi

  curl -sfL "$1" | grep -A2 'Date:' | grep -v 'Date' | grep -v -- -- | grep --color=none . | sort
}
