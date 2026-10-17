#!/usr/bin/env bash
# Fetch the CIFAR-10 dataset used by E2 (and the smoke tests) and verify its
# integrity. We do NOT ship the 166 MB tar in the repository; download it
# instead and confirm the official md5 before use.
#
# Usage:
#   bash data/cifar10_fetch.sh [OUT_DIR]
# Defaults OUT_DIR to ./data/cifar-10-batches-py (torchvision's expected layout).
set -euo pipefail

OUT_DIR="${1:-./data/cifar-10-batches-py}"
TARBALL="${OUT_DIR}/cifar-10-python.tar.gz"
EXPECTED_MD5="c58f30108f718f92721af3b95e74349a"

mkdir -p "$OUT_DIR"

if [ ! -f "$TARBALL" ]; then
  echo "Downloading CIFAR-10 (official torchvision source)..."
  curl -fSL "https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz" -o "$TARBALL"
fi

echo "Verifying md5..."
ACTUAL_MD5=$(md5sum "$TARBALL" | awk '{print $1}')
if [ "$ACTUAL_MD5" != "$EXPECTED_MD5" ]; then
  echo "ERROR: md5 mismatch (got $ACTUAL_MD5, expected $EXPECTED_MD5)" >&2
  exit 1
fi

echo "Extracting..."
tar -xzf "$TARBALL" -C "$OUT_DIR"

echo "Done. CIFAR-10 batches are in: $OUT_DIR/cifar-10-batches-py"
echo "Point E2 at it with --data-root $OUT_DIR (or copy into torchvision's cache)."
