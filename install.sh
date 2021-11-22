#!/bin/bash
set -eo pipefail

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  VARIANT="linux_amd64"
  TARGET_DIR="$HOME/bin"
  mkdir -p "$TARGET_DIR"
  TARGET="$TARGET_DIR/git-describe-semver"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  VARIANT="darwin_amd64"
  TARGET_DIR="$HOME/bin"
  mkdir -p "$TARGET_DIR"
  TARGET="$TARGET_DIR/git-describe-semver"
else
  echo "Unknown OS type $OSTYPE"
  exit 1
fi
LATEST_VERSION="$(curl -s https://api.github.com/repos/choffmeister/git-describe-semver/releases/latest | grep "tag_name" | awk '{print substr($2, 2, length($2)-3)}')"
URL="https://github.com/choffmeister/git-describe-semver/releases/download/$LATEST_VERSION/git-describe-semver_${LATEST_VERSION#v}_$VARIANT.tar.gz"
curl -fsSL "$URL" -o "$TARGET.tar.gz"
cd "$TARGET_DIR"
tar xfz "$TARGET.tar.gz"
rm "$TARGET.tar.gz"
