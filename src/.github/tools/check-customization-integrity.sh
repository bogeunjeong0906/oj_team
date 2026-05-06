#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
root_dir="$(cd "$script_dir/../.." && pwd)"

mapfile -d '' files < <(find "$root_dir" \( -path "$root_dir/.github" -o -path "$root_dir/.github/*" -o -path "$root_dir/README.md" \) \( -name '*.md' -o -name 'README.md' \) -type f -print0)

failures=0

check_target() {
    local source_file="$1"
    local raw_target="$2"
    local target="$raw_target"

    target="${target%%#*}"
    target="${target%%\?*}"

    if [[ -z "$target" ]]; then
        return 0
    fi

    if [[ "$target" =~ ^https?:// ]] || [[ "$target" =~ ^mailto: ]]; then
        return 0
    fi

    if [[ "$target" == /* ]]; then
        if [[ ! -e "$target" ]]; then
            printf 'Missing absolute path: %s -> %s\n' "$source_file" "$raw_target"
            failures=1
        fi
        return 0
    fi

    local source_dir
    source_dir="$(cd "$(dirname "$source_file")" && pwd)"
    local resolved
    resolved="$(cd "$source_dir" && realpath -m "$target")"

    if [[ ! -e "$resolved" ]]; then
        printf 'Missing relative path: %s -> %s\n' "$source_file" "$raw_target"
        failures=1
    fi
}

for file in "${files[@]}"; do
    while IFS= read -r target; do
        check_target "$file" "$target"
    done < <(grep -oE '\[[^]]+\]\(([^)]+)\)' "$file" | sed -E 's/^[^\(]*\(([^)]+)\)$/\1/')
done

if [[ "$failures" -ne 0 ]]; then
    exit 1
fi

printf 'Customization integrity check passed for %s\n' "$root_dir"