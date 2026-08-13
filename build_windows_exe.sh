#!/bin/bash
set -e

# ==============================================================================
# Script de Construcción Automatizada de Windows (.exe) para MUNNER 2D
# ==============================================================================

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="${PROJECT_DIR}/build"
WIN_BUILD_DIR="${BUILD_DIR}/windows"
OUTPUT_EXE_NAME="MUNNER_2D.exe"
OUTPUT_ZIP_NAME="MUNNER_2D-Windows-x86_64.zip"

echo "========================================================"
echo "🚀 Iniciando proceso de exportación para WINDOWS..."
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

# 2. Verificar templates de exportación de Windows
TEMPLATES_DIR="${HOME}/.local/share/godot/export_templates/4.7.1.stable"
if [ ! -f "${TEMPLATES_DIR}/windows_release_x86_64.exe" ]; then
    echo "⬇️ No se encontraron templates de Windows. Descargando..."
    mkdir -p "${TEMPLATES_DIR}"
    TMP_ZIP="/tmp/godot_templates_dl.tpz"
    curl -L -o "${TMP_ZIP}" "https://github.com/godotengine/godot/releases/download/4.7.1-stable/Godot_v4.7.1-stable_export_templates.tpz"
    unzip -q -o "${TMP_ZIP}" -d /tmp/godot_tmpl_extract
    mv /tmp/godot_tmpl_extract/templates/* "${TEMPLATES_DIR}/"
    rm -rf "${TMP_ZIP}" /tmp/godot_tmpl_extract
    echo "✅ Templates de Windows instalados correctamente."
fi

# 3. Preparar directorio de compilación
rm -rf "${WIN_BUILD_DIR}"
mkdir -p "${WIN_BUILD_DIR}"

# 4. Exportar ejecutable para Windows
echo "⚙️ Exportando ejecutable Windows (.exe) standalone..."
"${GODOT_BIN}" --headless --path "${PROJECT_DIR}" --export-release "Windows Desktop" "${WIN_BUILD_DIR}/${OUTPUT_EXE_NAME}"

if [ ! -f "${WIN_BUILD_DIR}/${OUTPUT_EXE_NAME}" ]; then
    echo "❌ ERROR: Falló la exportación de ${OUTPUT_EXE_NAME}"
    exit 1
fi

# 5. Copiar al directorio raíz y generar paquete ZIP para distribución
cp "${WIN_BUILD_DIR}/${OUTPUT_EXE_NAME}" "${PROJECT_DIR}/${OUTPUT_EXE_NAME}"

echo "📦 Creando archivo ZIP comprimido para distribución..."
cd "${WIN_BUILD_DIR}"
zip -q -9 "${BUILD_DIR}/${OUTPUT_ZIP_NAME}" "${OUTPUT_EXE_NAME}"
cd "${PROJECT_DIR}"
cp "${BUILD_DIR}/${OUTPUT_ZIP_NAME}" "${PROJECT_DIR}/${OUTPUT_ZIP_NAME}"

EXE_SIZE=$(du -h "${PROJECT_DIR}/${OUTPUT_EXE_NAME}" | cut -f1)
ZIP_SIZE=$(du -h "${PROJECT_DIR}/${OUTPUT_ZIP_NAME}" | cut -f1)

echo "========================================================"
echo "🎉 ¡EJECUTABLE DE WINDOWS GENERADO CON ÉXITO!"
echo "📍 Ejecutable standalone: ${PROJECT_DIR}/${OUTPUT_EXE_NAME} (${EXE_SIZE})"
echo "📍 Archivo ZIP listo para enviar: ${PROJECT_DIR}/${OUTPUT_ZIP_NAME} (${ZIP_SIZE})"
echo "========================================================"
