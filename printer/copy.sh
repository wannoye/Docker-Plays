#!/bin/bash
set -e
DATE=$(date +"%Y-%m-%d_%H%M%S")
MNT_DIR="/mnt/Xandar"
SCAN_DIR="/mnt/Xandar/Scans"

if mountpoint -q -- "$MNT_DIR"; then
    mkdir -p "$SCAN_DIR"
    printf '%s\n' "Starting Scan $DATE"
    sudo scanimage --format=tiff -p -o $SCAN_DIR/Scan_$DATE.tiff
    printf '%s\n'
    printf '%s\n' "Scan Complete"
    printf '%s\n' "Job $DATE Sent to Print Queue"
    lp -d Canon_MP495_series $SCAN_DIR/Scan_$DATE.tiff
    printf '%s\n' "Printing $SCAN_DIR/Scan_$DATE.tiff"
else
    printf '%s\n' "$MNT_DIR is not mounted."
    exit
fi

exit