#!/bin/bash
set -euo pipefail

echo "Demo for strict mode"

# Undefined variable (set -u)
echo $UNDEFINED_VAR

# Failing command (set -e)
ls /wrong-directory

# Pipeline failure (pipefail)
cat missing.txt | grep "test"