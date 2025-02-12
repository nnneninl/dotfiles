# if not running interactively, don't do anything
case "$-" in
	*i*)
		;;
	*)
		return
		;;
esac

# history
HISTFILE="$XDG_DATA_HOME/shell-history/$(date +%Y-%m-%d)"
HISTSIZE=10000
SAVEHIST=10000
setopt append_history

[ -f "$ZDOTDIR/../aliases" ] && . "$ZDOTDIR/../aliases"
[ -f "$ZDOTDIR/../functions" ] && . "$ZDOTDIR/../functions"
[ -f "$ZDOTDIR/prompt" ] && . "$ZDOTDIR/prompt"
[ -f "$ZDOTDIR/keybinds" ] && . "$ZDOTDIR/keybinds"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
