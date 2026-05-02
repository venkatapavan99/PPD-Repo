#!/bin/bash

set -e

echo "📦 Starting packaging..."

VERSION=$(cat version.txt)

mkdir -p build

ARTIFACT_NAME="Windows-Linux-PPD-$VERSION.zip"

zip -r build/$ARTIFACT_NAME src/ version.txt

echo "✅ Packaging completed: build/$ARTIFACT_NAME"
