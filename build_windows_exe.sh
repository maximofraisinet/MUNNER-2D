#!/bin/bash
set -e

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="${PROJECT_DIR}/build"
WIN_BUILD_DIR="${BUILD_DIR}/windows"
OUTPUT_EXE_NAME="MUNNER_2D.exe"
OUTPUT_ZIP_NAME="MUNNER_2D-Windows-x86_64.zip"
GODOT_BIN="${GODOT_BIN:-godot}"

if ! command -v "${GODOT_BIN}" >/dev/null 2>&1; then
    echo "Error: Godot executable ('${GODOT_BIN}') not found."
    exit 1
fi

echo "Starting Windows export..."

# Prepare build directory
rm -rf "${WIN_BUILD_DIR}"
mkdir -p "${WIN_BUILD_DIR}"

# Export Windows standalone executable
echo "Exporting executable (.exe)..."
"${GODOT_BIN}" --headless --path "${PROJECT_DIR}" --export-release "Windows Desktop" "${WIN_BUILD_DIR}/${OUTPUT_EXE_NAME}"

if [ ! -f "${WIN_BUILD_DIR}/${OUTPUT_EXE_NAME}" ]; then
    echo "Error: failed to export ${OUTPUT_EXE_NAME}"
    exit 1
fi

# Copy to project root and create distribution ZIP
cp "${WIN_BUILD_DIR}/${OUTPUT_EXE_NAME}" "${PROJECT_DIR}/${OUTPUT_EXE_NAME}"

if command -v zip >/dev/null 2>&1; then
    echo "Creating ZIP archive for distribution..."
    (cd "${WIN_BUILD_DIR}" && zip -q -9 "${BUILD_DIR}/${OUTPUT_ZIP_NAME}" "${OUTPUT_EXE_NAME}")
    cp "${BUILD_DIR}/${OUTPUT_ZIP_NAME}" "${PROJECT_DIR}/${OUTPUT_ZIP_NAME}"
    echo "ZIP archive successfully generated: ${PROJECT_DIR}/${OUTPUT_ZIP_NAME}"
fi

echo "Windows executable successfully generated: ${PROJECT_DIR}/${OUTPUT_EXE_NAME}"
