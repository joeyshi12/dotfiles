#!/bin/bash
# Render theme/templates into the repo and theme/dwl/colors.h into the dwl build and wakebar.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PALETTE="${ROOT_DIR}/theme/palette.sh"
TEMPLATE_DIR="${ROOT_DIR}/theme/templates"
COLORS_H_DIRS=("${HOME}/.local/src/dwl-wake-patches" "${HOME}/.local/src/wakebar")

set -a
# shellcheck source=theme/palette.sh
. "${PALETTE}"
set +a

# For each palette colour NAME='#rrggbb', also define NAME_HEX=rrggbb for
# programs that do not accept the leading #.
names="$(sed -n 's/^\([A-Z_][A-Z0-9_]*\)=.*/\1/p' "${PALETTE}")"
vars=""
for name in ${names}; do
    export "${name}_HEX=${!name#\#}"
    vars="${vars} \${${name}} \${${name}_HEX}"
done

# Substitute only the palette variables, so other $ signs in templates are kept.
render() {
    mkdir -p "$(dirname "$2")"
    envsubst "${vars}" < "$1" > "$2"
    echo "Wrote $2"
}

cd "${TEMPLATE_DIR}"
find . -type f | sort | while read -r template; do
    render "${template}" "${ROOT_DIR}/${template#./}"
done

for dir in "${COLORS_H_DIRS[@]}"; do
    if [ -d "${dir}" ]; then
        render "${ROOT_DIR}/theme/dwl/colors.h" "${dir}/colors.h"
    fi
done
