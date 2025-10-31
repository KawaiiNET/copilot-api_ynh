#!/bin/bash

# Script to calculate SHA256 hash for YunoHost manifest
# This downloads the release tarball and calculates its SHA256 hash

# Get absolute path to repository root
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PACKAGE_JSON="$REPO_ROOT/package.json"

# Read version from package.json
VERSION=$(grep '"version"' "$PACKAGE_JSON" | sed -E 's/.*"version": "([^"]+)".*/\1/')

if [ -z "$VERSION" ]; then
    echo "Error: Could not read version from package.json at $PACKAGE_JSON"
    exit 1
fi

TARBALL_URL="https://github.com/ericc-ch/copilot-api/archive/refs/tags/v${VERSION}.tar.gz"
TEMP_FILE="/tmp/copilot-api-v${VERSION}.tar.gz"

echo "Downloading release tarball for v${VERSION}..."
curl -L --max-time 30 --connect-timeout 10 -o "$TEMP_FILE" "$TARBALL_URL"

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
    
    # Check if manifest.toml exists and verify version consistency
    MANIFEST_FILE="$REPO_ROOT/manifest.toml"
    if [ -f "$MANIFEST_FILE" ]; then
        MANIFEST_VERSION=$(grep '^version = ' "$MANIFEST_FILE" | sed -E 's/version = "([^~]+)~.*/\1/')
        if [ "$VERSION" != "$MANIFEST_VERSION" ]; then
            echo ""
            echo "⚠️  WARNING: Version mismatch detected!"
            echo "   package.json version: $VERSION"
            echo "   manifest.toml version: $MANIFEST_VERSION"
            echo "   Please update manifest.toml to match package.json version"
        fi
    fi
    
    rm "$TEMP_FILE"
else
    echo "Error downloading tarball"
    exit 1
fi
