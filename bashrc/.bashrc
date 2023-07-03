# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
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
HISTSIZE=100000
HISTFILESIZE=200000
HISTTIMEFORMAT='%F %T '

shopt -s autocd
shopt -s cdspell
shopt -s checkwinsize

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
  cd $HOME
}

alias bashrc='vim ~/.bashrc'
alias cat='bat --color=always'
alias ghidra='cd /opt/ghidra_10.3.1_PUBLIC && ./ghidraRun && cd ~'
alias kube-config='vim ~/.kube/config'
alias ll='exa -a --long --header --git'
alias mkdir='mkdir -pv'
alias nord-connect='nordvpn connect United_States New_York'
alias nord-disconnect='nordvpn disconnect'
alias nord-status='nordvpn status'
alias nvidia-issue='sudo systemctl restart nvidia-powerd.service'
alias ssh-config='vim ~/.ssh/config'
alias top=htop
alias tor="if [ $(stat -c %g /run/tor/) != $GROUPS ] || [ $(stat -c %u /run/tor/) != $UID ] ; then sudo chown $USER:$USER /run/tor/ && tor ; else tor ; fi"
alias tor-browser='cd /opt/tor-browser_en-US/ && ./start-tor-browser.desktop && cd ~'
alias update-starship='curl -sS https://starship.rs/install.sh | sh'
alias vim='vim -p'
alias vimrc='vim ~/.vimrc'
alias whatismyip='curl -sfL myadd.ir/ip ; echo'
alias whatismyasn='curl -sfL myadd.ir/asnfull ; echo'
alias wireguard_keys='wg keygen | tee privatekey | wg pubkey > publickey'

# Confirmation + Verbose
alias cp='cp -iv'
alias ln='ln -iv'
alias mv='mv -iv'
alias rm='rm -iv'

# $PATH modifications for bcc
# export PATH=$PATH:/usr/share/bcc/tools

# $PATH modification for rust
export PATH=$PATH:$HOME/.cargo/bin

# Starship Enabler
eval "$(starship init bash)"

# Starship Configuration Path
export STARSHIP_CONFIG=~/.config/starship/starship.toml
