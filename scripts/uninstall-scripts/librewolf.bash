source scripts/helpers.bash

repo_root="$PWD"
cd "$HOME/Library/Application Support/librewolf" >/dev/null

if [[ -z "$LIBREWOLF_PROFILES" ]]; then
	LIBREWOLF_PROFILES="$(sed -n 's/Default=\(.*\)/\1/gp' installs.ini | tr '\n' ':')"
	echo "The default profiles of every librewolf installation will be altered. The profiles are: $LIBREWOLF_PROFILES. To explicitely choose the profiles, set the \$LIBREWOLF_PROFILES environment variable to a string delimited with colons"
fi

IFS=:
for dir in $LIBREWOLF_PROFILES; do
	dir="$(realpath "$dir")"
	mkdir -p "$dir/chrome"
	try_revert_ln "$repo_root/librewolf/userChrome.css" "$dir/chrome/userChrome.css"
done
