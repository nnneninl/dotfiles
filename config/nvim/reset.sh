#!/bin/sh

NVIM_CACHE="$HOME"/.cache/nvim
NVIM_SHARE="$HOME"/.local/share/nvim
NVIM_STATE="$HOME"/.local/state/nvim
LOCK_FILE="./lazy-lock.json"

DIRS_TO_REMOVE=""
[ -d "$NVIM_CACHE" ] && DIRS_TO_REMOVE="$DIRS_TO_REMOVE $NVIM_CACHE"
[ -d "$NVIM_SHARE" ] && DIRS_TO_REMOVE="$DIRS_TO_REMOVE $NVIM_SHARE"
[ -d "$NVIM_STATE" ] && DIRS_TO_REMOVE="$DIRS_TO_REMOVE $NVIM_STATE"

FILE_TO_REMOVE=""
[ -f "$LOCK_FILE" ] && FILE_TO_REMOVE="$LOCK_FILE"

if [ -n "$DIRS_TO_REMOVE" ] || [ -n "$FILE_TO_REMOVE" ] ; then
	clear

	printf "[ALERT]: This script will remove the following:\n"
	for dir in $DIRS_TO_REMOVE; do
		printf "%s\n" "$dir"
	done
	[ -n "$FILE_TO_REMOVE" ] && printf "%s\n" "$FILE_TO_REMOVE"
	printf "\nProceed? (y/N): "
	read -r ans

	case "$ans" in
		[yY])
			[ -n "$DIRS_TO_REMOVE" ] && rm -rf $DIRS_TO_REMOVE
			[ -n "$FILE_TO_REMOVE" ] && shred -uz "$FILE_TO_REMOVE"
			printf "\n[SUCCESS]: Selected files and directories removed.\n\n"
			exit 0
			;;
		[nN])
			printf "\n[SUCCESS]: No changes made.\n\n"
			exit 0
			;;
		*)
			printf "\n[ERROR]: Invalid input. Aborted.\n\n"
			exit 1
			;;
	esac
else
	printf "\n[SUCCESS]: None of the neovim-related directories or lazy-lock.json file found. No reset needed.\n\n"
	exit 0
fi
