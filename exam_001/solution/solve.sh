#!/bin/bash

LOG_FILE="/data/access.log"
OUTPUT_FILE="/output/report.txt"

mkdir -p /output

{
    echo "=== Top IP ==="
    awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -1 | awk '{print $2 ": " $1 " requests"}'
    
    echo ""
    echo "=== Status Code Distribution ==="
    awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -rn | awk '{print $2 ": " $1}'
} > "$OUTPUT_FILE"

echo "Report generated at $OUTPUT_FILE"