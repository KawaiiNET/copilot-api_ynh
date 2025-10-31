#!/bin/bash

# Script to calculate SHA256 hash for YunoHost manifest
# This downloads the release tarball and calculates its SHA256 hash

# Read version from package.json
VERSION=$(grep '"version"' "$(dirname "$0")/../package.json" | sed -E 's/.*"version": "([^"]+)".*/\1/')

if [ -z "$VERSION" ]; then
    echo "Error: Could not read version from package.json"
    exit 1
fi

TARBALL_URL="https://github.com/ericc-ch/copilot-api/archive/refs/tags/v${VERSION}.tar.gz"
TEMP_FILE="/tmp/copilot-api-v${VERSION}.tar.gz"

echo "Downloading release tarball for v${VERSION}..."
curl -L -o "$TEMP_FILE" "$TARBALL_URL"

if [ $? -eq 0 ]; then
    echo ""
    echo "Calculating SHA256 hash..."
    SHA256=$(sha256sum "$TEMP_FILE" | awk '{print $1}')
    echo ""
    echo "=========================================="
    echo "SHA256 hash for v${VERSION}:"
    echo "$SHA256"
    echo "=========================================="
    echo ""
    echo "Update this value in manifest.toml under [resources.sources.main]"
    rm "$TEMP_FILE"
else
    echo "Error downloading tarball"
    exit 1
fi
