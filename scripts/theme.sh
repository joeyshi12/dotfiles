#!/bin/bash
# Regenerate the colour files from theme/palette.sh.
# Each file under theme/templates is written to the same path in the repo root.
# theme/dwl/colors.h is written to the dwl source directory if it exists.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PALETTE="${ROOT_DIR}/theme/palette.sh"
TEMPLATE_DIR="${ROOT_DIR}/theme/templates"
DWL_DIR="${HOME}/.local/src/dwl"

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

if [ -d "${DWL_DIR}" ]; then
    render "${ROOT_DIR}/theme/dwl/colors.h" "${DWL_DIR}/colors.h"
fi
