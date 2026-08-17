#!/bin/bash
set -e

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="${PROJECT_DIR}/build"
APPDIR="${BUILD_DIR}/AppDir"
TOOLS_DIR="${BUILD_DIR}/tools"
OUTPUT_NAME="MUNNER_2D-x86_64.AppImage"
OUTPUT_APPIMAGE="${BUILD_DIR}/${OUTPUT_NAME}"
GODOT_BIN="${GODOT_BIN:-godot}"

if ! command -v "${GODOT_BIN}" >/dev/null 2>&1; then
    echo "Error: Godot executable ('${GODOT_BIN}') not found."
    exit 1
fi

echo "Starting AppImage build..."

# Prepare build directories
rm -rf "${APPDIR}"
mkdir -p "${APPDIR}/usr/bin" "${TOOLS_DIR}"

# Export resource pack (.pck)
echo "Exporting resource pack (.pck)..."
"${GODOT_BIN}" --headless --path "${PROJECT_DIR}" --export-pack "Linux" "${APPDIR}/usr/bin/runner.pck"

if [ ! -f "${APPDIR}/usr/bin/runner.pck" ]; then
    echo "Error: failed to export runner.pck"
    exit 1
fi

# Copy Godot executable as runtime
cp "$(command -v "${GODOT_BIN}")" "${APPDIR}/usr/bin/runner"
chmod +x "${APPDIR}/usr/bin/runner"

# Create AppRun launcher
cat << 'EOF' > "${APPDIR}/AppRun"
#!/bin/sh
HERE="$(dirname "$(readlink -f "${0}")")"
exec "${HERE}/usr/bin/runner" --main-pack "${HERE}/usr/bin/runner.pck" "$@"
EOF
chmod +x "${APPDIR}/AppRun"

# Create .desktop entry
cat << EOF > "${APPDIR}/runner.desktop"
[Desktop Entry]
Type=Application
Name=MUNNER 2D
GenericName=Endless Runner 2D
Comment=Endless Runner game built with Godot Engine 4
Exec=AppRun
Icon=runner
Categories=Game;ArcadeGame;
Terminal=false
StartupNotify=true
EOF

# Copy icons
if [ -f "${PROJECT_DIR}/icon.png" ]; then
    cp "${PROJECT_DIR}/icon.png" "${APPDIR}/runner.png"
    cp "${PROJECT_DIR}/icon.png" "${APPDIR}/.DirIcon"
fi

# Download appimagetool if not present
APPIMAGETOOL="${TOOLS_DIR}/appimagetool"
if [ ! -f "${APPIMAGETOOL}" ]; then
    echo "Downloading appimagetool..."
    curl -L -s -o "${APPIMAGETOOL}" "https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage"
    chmod +x "${APPIMAGETOOL}"
fi

# Generate AppImage
echo "Packaging AppImage..."
export ARCH=x86_64
"${APPIMAGETOOL}" --no-appstream "${APPDIR}" "${OUTPUT_APPIMAGE}"

if [ -f "${OUTPUT_APPIMAGE}" ]; then
    chmod +x "${OUTPUT_APPIMAGE}"
    cp "${OUTPUT_APPIMAGE}" "${PROJECT_DIR}/${OUTPUT_NAME}"
    echo "AppImage successfully generated: ${PROJECT_DIR}/${OUTPUT_NAME}"
else
    echo "Error: failed to generate AppImage."
    exit 1
fi
