#!/bin/bash

set -e

VERSION=$(cat version.txt)
ARTIFACT="build/Windows-Linux-PPD-$VERSION.zip"

if [ ! -f "$ARTIFACT" ]; then
  echo "❌ Artifact not found!"
  exit 1
fi

NEXUS_URL="http://13.217.210.104:8082/repository/ppd-drivers"
USERNAME=$NEXUS_USERNAME
PASSWORD=$NEXUS_PASSWORD

echo "🚀 Uploading artifact to Nexus..."

curl -u $USERNAME:$PASSWORD \
     --upload-file "$ARTIFACT" \
     "$NEXUS_URL/ppd-driver-$VERSION.zip" \
     || { echo "❌ Upload failed"; exit 1; }

echo "✅ Upload successful"
