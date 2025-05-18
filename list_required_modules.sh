#!/bin/bash

# Recursively find all .py files from the current directory
echo "Scanning Python files for imports..."

# Extract all import statements and clean them to get top-level module names
grep -hrE '^ *(import|from) ' . \
  --include="*.py" \
  | sed -E 's/^ *import +//; s/^ *from +//; s/ .*//; s/\..*//' \
  | sort -u \
  | grep -vE '^(__|sys|os|typing|re|math|builtins|logging|time|random|json|itertools|collections|dataclasses|copy|argparse|pathlib|threading|warnings|functools|enum|subprocess|shutil|pickle|uuid)$' \
  > required_modules.txt

echo "Modules required (saved in required_modules.txt):"
cat required_modules.txt

