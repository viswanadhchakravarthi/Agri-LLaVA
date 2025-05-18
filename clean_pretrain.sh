#!/bin/bash

TARGET="scripts/pretrain.sh"

echo "Cleaning $TARGET..."

# Step 1: Remove Windows carriage returns (\r)
tr -d '\r' < "$TARGET" > "$TARGET.tmp" && mv "$TARGET.tmp" "$TARGET"

# Step 2: Insert PYTHONPATH export line after the shebang if not already present
if ! grep -q "export PYTHONPATH" "$TARGET"; then
    awk 'NR==1 { print; print "export PYTHONPATH=$(pwd)"; next } 1' "$TARGET" > "$TARGET.tmp" && mv "$TARGET.tmp" "$TARGET"
    echo "Added PYTHONPATH line."
else
    echo "PYTHONPATH line already present."
fi

# Step 3: Make it executable
chmod +x "$TARGET"

echo "Done cleaning $TARGET."

