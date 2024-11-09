# OH MY ZSH
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="xiong-chiamiov-plus"

# PLUGINS
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# POKEMON COLOR SCHEME
# git clone https://gitlab.com/phoneybadger/pokemon-colorscripts.git
# cd pokemon-colorscripts
# sudo ./install.sh

pokemon-colorscripts --no-title -s -r

# ZSH HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory


#{ CUSTOM

# DESKTOP
export WEBKIT_DISABLE_DMABUF_RENDERER=1

# ANDROID
export JAVA_HOME=/opt/android-studio/jbr
export ANDROID_HOME="$HOME/Android/Sdk"
export NDK_HOME="$ANDROID_HOME/ndk/$(ls -1 $ANDROID_HOME/ndk)"
# export ANDROID_HOME=$HOME/Android/Sdk
# export PATH=$PATH:$ANDROID_HOME/emulator
# export PATH=$PATH:$ANDROID_HOME/tools
# export PATH=$PATH:$ANDROID_HOME/tools/bin
# export PATH=$PATH:$ANDROID_HOME/platform-tools

# Aliases
alias v='nvim'
alias tvs='cd /mnt/sda6/"TV Series"'
alias cnm='cd /mnt/sda6/Movies'
alias projects='/mnt/B0901BA8901B73D6/productivity-nd-duh/Projects'
alias porto='/mnt/B0901BA8901B73D6/productivity-nd-duh/Projects/portfolio'
alias android-studio='/opt/android-studio/bin/studio'
# alias emu='emulator -avd Pixel_4_API_34'

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export PATH="$PATH:/opt/nvim-linux64/bin"

# Load Angular CLI autocompletion.
source <(ng completion script)
. "$HOME/.deno/env"
# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

#} CUSTOM


# STARSHIP 
# curl -sS https://starship.rs/install.sh | sh

eval "$(starship init zsh)"

