#!/bin/bash

set -e

echo "📦 Starting packaging..."

# Check version file
if [ ! -f version.txt ]; then
  echo "❌ version.txt not found!"
  exit 1
fi

VERSION=$(cat version.txt)

if [ -z "$VERSION" ]; then
  echo "❌ Version is empty!"
  exit 1
fi

echo "🔢 Version: $VERSION"

# Create build directory
mkdir -p build

# Check PPD file
PPD_FILE=$(find . -name "*.ppd" | head -n 1)

if [ -z "$PPD_FILE" ]; then
  echo "❌ No PPD file found for packaging!"
  exit 1
fi

# Define package name
PACKAGE_NAME="Windows-Linux-PPD-${VERSION}.zip"

echo "📁 Packaging: $PACKAGE_NAME"

# Create ZIP
zip -j build/$PACKAGE_NAME $PPD_FILE version.txt

echo "✅ Packaging completed: build/$PACKAGE_NAME"
