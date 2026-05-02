#!/bin/bash

set -e

PPD_FILE=$(find . -name "*.ppd" | head -n 1)

if [ -z "$PPD_FILE" ]; then
  echo "❌ No PPD file found!"
  exit 1
fi

echo "✅ Found PPD: $PPD_FILE"

cupstestppd $PPD_FILE

if [ $? -ne 0 ]; then
  echo "❌ PPD validation failed"
  exit 1
fi

echo "✅ PPD validation successful"
