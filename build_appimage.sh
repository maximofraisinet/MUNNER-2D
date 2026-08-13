#!/bin/bash
set -e

# ==============================================================================
# Script de Construcción Automatizada de AppImage para MUNNER 2D
# ==============================================================================

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="${PROJECT_DIR}/build"
APPDIR="${BUILD_DIR}/AppDir"
TOOLS_DIR="${BUILD_DIR}/tools"
OUTPUT_NAME="MUNNER_2D-x86_64.AppImage"
OUTPUT_APPIMAGE="${BUILD_DIR}/${OUTPUT_NAME}"

echo "========================================================"
echo "🚀 Iniciando proceso de construcción de AppImage..."
echo "📁 Directorio del proyecto: ${PROJECT_DIR}"
echo "========================================================"

# 1. Localizar binario de Godot Engine
GODOT_BIN=""
CANDIDATE_PATHS=(
    "/home/maximo/Descargas/Godot_v4.7.1-stable_linux.x86_64"
    "$(which godot 2>/dev/null || true)"
    "$(which godot4 2>/dev/null || true)"
    "$(find /home/maximo/Descargas -maxdepth 2 -name "Godot_v4*" -type f -executable 2>/dev/null | head -n 1 || true)"
)

for candidate in "${CANDIDATE_PATHS[@]}"; do
    if [ -n "${candidate}" ] && [ -x "${candidate}" ]; then
        GODOT_BIN="${candidate}"
        break
    fi
done

if [ -z "${GODOT_BIN}" ]; then
    echo "❌ ERROR: No se encontró el ejecutable de Godot 4."
    exit 1
fi

echo "✅ Utilizando Godot Engine: ${GODOT_BIN}"

# 2. Limpiar y preparar estructura de AppDir
echo "🧹 Preparando directorios de compilación..."
rm -rf "${APPDIR}"
mkdir -p "${APPDIR}/usr/bin"
mkdir -p "${TOOLS_DIR}"

# 3. Exportar paquete del juego (.pck)
echo "📦 Exportando paquete de recursos (.pck)..."
"${GODOT_BIN}" --headless --path "${PROJECT_DIR}" --export-pack "Linux" "${APPDIR}/usr/bin/runner.pck"

if [ ! -f "${APPDIR}/usr/bin/runner.pck" ]; then
    echo "❌ ERROR: Falló la exportación de runner.pck"
    exit 1
fi

# 4. Copiar ejecutable de runtime
echo "⚙️ Configurando binario ejecutable..."
cp "${GODOT_BIN}" "${APPDIR}/usr/bin/runner"
chmod +x "${APPDIR}/usr/bin/runner"

# 5. Crear script lanzador AppRun
echo "📝 Generando lanzador AppRun..."
cat << 'EOF' > "${APPDIR}/AppRun"
#!/bin/sh
HERE="$(dirname "$(readlink -f "${0}")")"
exec "${HERE}/usr/bin/runner" --main-pack "${HERE}/usr/bin/runner.pck" "$@"
EOF
chmod +x "${APPDIR}/AppRun"

# 6. Crear archivo .desktop
echo "📄 Creando entrada de escritorio (.desktop)..."
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

# 7. Copiar iconos de la aplicación
echo "🎨 Copiando iconos de la aplicación..."
if [ -f "${PROJECT_DIR}/icon.png" ]; then
    cp "${PROJECT_DIR}/icon.png" "${APPDIR}/runner.png"
    cp "${PROJECT_DIR}/icon.png" "${APPDIR}/.DirIcon"
fi

# 8. Descargar appimagetool si no existe
APPIMAGETOOL="${TOOLS_DIR}/appimagetool"
if [ ! -f "${APPIMAGETOOL}" ]; then
    echo "⬇️ Descargando appimagetool..."
    curl -L -s -o "${APPIMAGETOOL}" "https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage"
    chmod +x "${APPIMAGETOOL}"
fi

# 9. Generar el AppImage final
echo "🔨 Empaquetando AppImage con appimagetool..."
export ARCH=x86_64
"${APPIMAGETOOL}" --no-appstream "${APPDIR}" "${OUTPUT_APPIMAGE}"

if [ -f "${OUTPUT_APPIMAGE}" ]; then
    chmod +x "${OUTPUT_APPIMAGE}"
    # Crear enlace o copia en el root del proyecto
    cp "${OUTPUT_APPIMAGE}" "${PROJECT_DIR}/${OUTPUT_NAME}"
    echo ""
    echo "========================================================"
    echo "🎉 ¡APPIMAGE GENERADO CON ÉXITO!"
    echo "📍 Ubicación 1: ${OUTPUT_APPIMAGE}"
    echo "📍 Ubicación 2: ${PROJECT_DIR}/${OUTPUT_NAME}"
    echo "⚖️ Tamaño del AppImage: $(ls -lh "${PROJECT_DIR}/${OUTPUT_NAME}" | awk '{print $5}')"
    echo "▶️ Para ejecutarlo: ./${OUTPUT_NAME}"
    echo "========================================================"
else
    echo "❌ ERROR: No se pudo generar el archivo AppImage."
    exit 1
fi
