#!/usr/bin/env bash

if [[ "$BASH_SOURCE" != "$0" ]]; then
  echo "run this file, don't source it."
  return
fi

cd "$(dirname "$BASH_SOURCE")"
cd ..

if [[ "$(command -v stow)" == "" ]]; then
  if [[ "$(command -v brew)" != "" ]]; then
    command brew install stow
  else
    echo "Stow not found."
    exit
  fi
fi

for module in "$@"; do
  if ! [[ -d "$module" ]]; then
    echo "Module '$module' not found."
    continue
  fi

  stow "$module"

  if [[ "$(uname -s)" == "Darwin" ]] && [[ -f "scripts/setup-$module-mac.sh" ]]; then
    "scripts/setup-$module-mac.sh"
  fi
done
