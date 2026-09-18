source scripts/helpers.bash

repo_root="$PWD"
cd "$LIBREWOLF_ROOT" || cd "$HOME/Library/Application Support/librewolf" || cd "$HOME/.librewolf" || {
	echo "$HOME/Library/Application Support/ and $HOME/.librewolf both didn't exist. Please specify the path your librewolf directory (the one installs.ini) using the LIBREWOLF_ROOT environment variable."
}

if [[ -z "$LIBREWOLF_PROFILES" ]]; then
	LIBREWOLF_PROFILES="$(sed -n 's/Default=\(.*\)/\1/gp' installs.ini | tr '\n' ':')"
	echo "The default profiles of every librewolf installation will be altered. The profiles are: '$LIBREWOLF_PROFILES'. To explicitely choose the profiles, set the \$LIBREWOLF_PROFILES environment variable to a string delimited with colons"
fi

IFS=:
for dir in $LIBREWOLF_PROFILES; do
	dir="$(realpath "$dir")"
	mkdir -p "$dir/chrome"
	try_ln "$repo_root/librewolf/userChrome.css" "$dir/chrome/userChrome.css"
done
