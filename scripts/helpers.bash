backup() {
	[[ -e "$1" ]] || return
	echo "$1 already exists, moving up to $1.bak..."
	backup "$1.bak"
	mv "$1" "$1.bak"
}

restore_backup() {
	[[ -e "$1.bak" ]] || return
	echo "Restoring backup $1.bak to $1"
	mv "$1.bak" "$1"
	restore_backup "$1.bak"
}

try_ln() {
	echo "Creating symlink for $1 at $2..."
	mkdir -p "$(dirname "$2")"
	backup "$2"
	ln -s "$(realpath "$1")" "$2"
}

try_revert_ln() {
	if ! [[ -e "$2" ]]; then
		echo "$2 not found"
		exit 1
	fi

	if [[ "$(realpath "$2")" != "$(realpath "$1")" ]]; then
		echo "$2 was not a symlink for $1, not deleting it."
		exit 1
	fi

	echo "Removing symlink for $1 at $2..."
	rm -rf "$2"

	restore_backup "$2"
}

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
