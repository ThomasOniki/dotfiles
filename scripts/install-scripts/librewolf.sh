#!/bin/sh

root="$(dirname "$(readlink -f -- "$0")")/../.."
. "$root/scripts/helpers.sh"

last_cwd="$PWD"

cd "${LIBREWOLF_ROOT:-$HOME/.librewolf}" >/dev/null 2>&1 ||
	cd "${XDG_CONFIG_HOME:-$HOME/.config}/librewolf/librewolf" >/dev/null 2>&1 ||
	cd "$HOME/Library/Application Support/librewolf" >/dev/null 2>&1 ||
	{
		echo "The librewolf root directory (the one with installs.ini) was not found.
If you have installed librewolf to a non-standard location, try setting the LIBREWOLF_ROOT environment variable before running this script."
		exit 1
	}

if [ -z "$LIBREWOLF_PROFILES" ]; then
	LIBREWOLF_PROFILES="$(sed -n 's/Default=\(.*\)/\1/gp' installs.ini | tr '\n' ':')"
	echo "The default profiles of every librewolf installation will be altered. The profiles are: '$LIBREWOLF_PROFILES'. To explicitely choose the profiles, set the \$LIBREWOLF_PROFILES environment variable to a string delimited with colons"
fi

IFS=:
for dir in $LIBREWOLF_PROFILES; do
	dir="$(realpath "$dir")"
	mkdir -p "$dir/chrome"
	try_ln "$root/librewolf/userChrome.css" "$dir/chrome/userChrome.css"
done

cd "$last_cwd"
