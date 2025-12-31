#!/usr/bin/env bash
set -euo pipefail

PKG_NAME="joknarf-repo"
PKG_VERSION="1.0"
PKG_DIR="${PKG_NAME}_${PKG_VERSION}"

REPO_URL="https://joknarf.github.io/deb"
DIST="stable"
COMPONENT="main"

# Cleanup
rm -rf "$PKG_DIR"

# Create directory structure
mkdir -p "$PKG_DIR/DEBIAN"
mkdir -p "$PKG_DIR/etc/apt/sources.list.d"

# control file
cat > "$PKG_DIR/DEBIAN/control" <<EOF
Package: $PKG_NAME
Version: $PKG_VERSION
Section: admin
Priority: optional
Architecture: all
Maintainer: joknarf <joknarf@free.fr>
Description: Enable Joknarf APT repository
Build-Date: $(date +%s)
EOF

# APT source
cat > "$PKG_DIR/etc/apt/sources.list.d/joknarf.list" <<EOF
deb [trusted=yes] $REPO_URL $DIST $COMPONENT
EOF

# postinst
cat > "$PKG_DIR/DEBIAN/postinst" <<'EOF'
#!/bin/sh
set -e
apt-get update || true
exit 0
EOF

chmod 755 "$PKG_DIR/DEBIAN/postinst"

# Build package
dpkg-deb --build "$PKG_DIR"

echo "Built ${PKG_DIR}.deb"

