#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-./repo}"
DIST="${2:-stable}"
COMPONENT="${3:-main}"
ARCHS=("amd64" "arm64")  # support multiple architectures

mkdir -p "$REPO_ROOT/pool/main"

for ARCH in "${ARCHS[@]}"; do
    mkdir -p "$REPO_ROOT/dists/$DIST/$COMPONENT/binary-$ARCH"
done

echo "DEB repo initialized at $REPO_ROOT"
echo "Distribution: $DIST"
echo "Component: $COMPONENT"
echo "Architectures: ${ARCHS[*]}"

