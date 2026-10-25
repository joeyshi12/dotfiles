#!/bin/bash
# Render theme/templates into the repo, theme/dwl/colors.h into the dwl build,
# the Vesktop theme into its themes folder, and the GTK 3 and 4 colours and the
# Flameshot settings into ~/.config.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PALETTE="${ROOT_DIR}/theme/palette.sh"
TEMPLATE_DIR="${ROOT_DIR}/theme/templates"
COLORS_H_DIRS=("${HOME}/.local/src/dwl")
VESKTOP_DIR="${HOME}/.config/vesktop"

set -a
# shellcheck source=theme/palette.sh
. "${PALETTE}"
set +a

# For each palette colour NAME='#rrggbb', also define NAME_HEX=rrggbb for
# programs that do not accept the leading #, and NAME_RGB=r,g,b for KDE colour schemes.
names="$(sed -n 's/^\([A-Z_][A-Z0-9_]*\)=.*/\1/p' "${PALETTE}")"
vars=""
for name in ${names}; do
    hex="${!name#\#}"
    export "${name}_HEX=${hex}"
    export "${name}_RGB=$((16#${hex:0:2})),$((16#${hex:2:2})),$((16#${hex:4:2}))"
    vars="${vars} \${${name}} \${${name}_HEX} \${${name}_RGB}"
done

# Substitute only the palette variables, so other $ signs in templates are kept. The target is
# removed first, so a symlink (as nwg-look leaves in ~/.config/gtk-4.0) is replaced, not followed.
render() {
    mkdir -p "$(dirname "$2")"
    rm -f "$2"
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

render "${ROOT_DIR}/theme/gtk/gtk.css" "${HOME}/.config/gtk-3.0/gtk.css"
render <(cat "${ROOT_DIR}/theme/gtk/gtk.css" "${ROOT_DIR}/theme/gtk/variables.css") "${HOME}/.config/gtk-4.0/gtk.css"

# Flameshot needs an absolute save path, so it is written per user like the GTK colours
vars="${vars} \${HOME}" render "${ROOT_DIR}/theme/flameshot/flameshot.ini" "${HOME}/.config/flameshot/flameshot.ini"

if [ -d "${VESKTOP_DIR}" ]; then
    render "${ROOT_DIR}/theme/vesktop/WakeNight.theme.css" "${VESKTOP_DIR}/themes/WakeNight.theme.css"
fi
