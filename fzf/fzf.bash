if [[ -z "$FZF_PATH" ]]; then
  _fg_red=$(tput setaf 1)
  _reset=$(tput sgr0)
  echo "${_fg_red}ERROR${_reset}: FZF_PATH is not set"
  return
fi

# Setup fzf
# ---------
[[ ! "$PATH" == *$FZF_PATH/bin* ]] && export PATH="$PATH:$FZF_PATH/bin"

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$FZF_PATH/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
# Note the order is important because some functions get overridden
source $FZF_PATH/shell/key-bindings.bash
source $HOME/.dotfiles/fzf/fzf_vcs.bash
source $HOME/.dotfiles/fzf/key-bindings.bash

# Customisations
# --------------
# export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind=ctrl-n:down,ctrl-p:up,alt-n:next-history,alt-p:previous-history --height ${FZF_TMUX_HEIGHT:-40%} --ansi --exit-0"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --height ${FZF_TMUX_HEIGHT:-40%} --ansi --exit-0 --reverse"
# export FZF_CTRL_T_OPTS='--expect=alt-v,alt-e,alt-c'
