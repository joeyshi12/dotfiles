#!/bin/bash
# Regenerate the colour files from theme/palette.sh.
# Each file under theme/templates is written to the same path in the repo root.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PALETTE="${ROOT_DIR}/theme/palette.sh"
TEMPLATE_DIR="${ROOT_DIR}/theme/templates"

set -a
# shellcheck source=theme/palette.sh
. "${PALETTE}"
set +a

# Substitute only the palette variables, so other $ signs in templates are kept.
vars="$(sed -n 's/^\([A-Z_][A-Z0-9_]*\)=.*/${\1}/p' "${PALETTE}" | tr '\n' ' ')"

cd "${TEMPLATE_DIR}"
find . -type f | sort | while read -r template; do
    target="${ROOT_DIR}/${template#./}"
    mkdir -p "$(dirname "${target}")"
    envsubst "${vars}" < "${template}" > "${target}"
    echo "Wrote ${template#./}"
done
