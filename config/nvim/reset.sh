#!/bin/sh

NVIM_CACHE="$HOME"/.cache/nvim
NVIM_SHARE="$HOME"/.local/share/nvim
NVIM_STATE="$HOME"/.local/state/nvim

clear
printf "[ALERT]: This script will remove the following directories:\n"
printf "%s\n%s\n%s\n\n" "$NVIM_CACHE" "$NVIM_SHARE" "$NVIM_STATE"
printf "Proceed? (y/N): "
read -r ans

case "$ans" in
	[yY])
		rm -rf "$NVIM_CACHE" "$NVIM_SHARE" "$NVIM_STATE"
		printf "[SUCCESS]: Directories removed.\n\n"
		exit 0
		;;
	[nN])
		printf "[SUCCESS]: Answered no.\n\n"
		exit 0
		;;
	*)
		printf "[ERROR]: Invalid answer.\n\n"
		exit 1
		;;
esac
