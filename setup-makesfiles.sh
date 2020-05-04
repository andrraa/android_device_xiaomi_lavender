  
#!/bin/bash
#
# Copyright (C) 2018-2019 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=lavender
VENDOR=xiaomi

INITIAL_COPYRIGHT_YEAR=2019

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi

DU_ROOT="${MY_DIR}/../../.."

HELPER="$DU_ROOT"/vendor/du/build/tools/extract_utils.sh
if [ ! -f "$HELPER" ]; then
    echo "Unable to find helper script at $HELPER"
    exit 1
fi
. "$HELPER"

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${DU_ROOT}"

# Copyright headers and guards
write_headers

write_makefiles "$MY_DIR"/proprietary-files.txt true
echo "" >> "$PRODUCTMK"
write_makefiles "$MY_DIR"/proprietary-files-qc.txt true

# Finish
write_footers
