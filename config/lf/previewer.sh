#!/bin/sh

case "$(readlink -f "$1")" in
	*.7z)
		7z l "$1"
		;;
	*.rar)
		unrar l "$1"
		;;
	*.tar)
		tar tf "$1"
		;;
	*.tar.bz2|*.tbz)
		tar tjf "$1"
		;;
	*.tar.gz|*.tgz)
		tar tzf "$1"
		;;
	*.tar.txz|*.txz)
		xz -l "$1"
		;;
	*.zip)
		unzip -l "$1"
		;;
	*.iso)
		iso-info --no-header -l "$1"
		;;
	*.o)
		nm "$1"
		;;
	*.torrent)
		transmission-show "$1"
		;;
	*)
		cat "$1"
		;;
esac
