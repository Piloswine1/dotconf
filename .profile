eval "$(starship init bash)"
eval "$(zoxide init bash)"
#
# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fdfind --type f --strip-cwd-prefix'
# SET TERM
export TERM=tmux-256color
export EDITOR=nvim
#
# set tmux on login
[ -x "$(command -v tmux)" ] \
&& [ -z "${TMUX}" ] \
&& { tmux attach || tmux; } >/dev/null 2>&1
