#!/bin/bash
set -e

REPORT="/output/report.txt"
REWARD_FILE="/logs/verifier/reward.txt"

mkdir -p /logs/verifier

# Check if report exists
if [ ! -f "$REPORT" ]; then
    echo "FAIL: $REPORT not found"
    echo "0" > "$REWARD_FILE"
    exit 0
fi

SCORE=0
TOTAL=4

# Test 1: Check Top IP section exists
if grep -q "=== Top IP ===" "$REPORT"; then
    echo "PASS: Top IP section found"
    SCORE=$((SCORE + 1))
else
    echo "FAIL: Top IP section not found"
fi

# Test 2: Check correct top IP (192.168.1.100 has 5 requests)
if grep -q "192.168.1.100" "$REPORT" && grep -q "5" "$REPORT"; then
    echo "PASS: Correct top IP identified"
    SCORE=$((SCORE + 1))
else
    echo "FAIL: Top IP should be 192.168.1.100 with 5 requests"
fi

# Test 3: Check Status Code Distribution section
if grep -q "=== Status Code Distribution ===" "$REPORT"; then
    echo "PASS: Status Code Distribution section found"
    SCORE=$((SCORE + 1))
else
    echo "FAIL: Status Code Distribution section not found"
fi

# Test 4: Check status code counts
if grep -q "200:" "$REPORT" && grep -q "404:" "$REPORT"; then
    echo "PASS: Status codes listed"
    SCORE=$((SCORE + 1))
else
    echo "FAIL: Status codes not properly listed"
fi

# Calculate reward
REWARD=$(awk -v s="$SCORE" -v t="$TOTAL" 'BEGIN {printf "%.2f", s/t}')
echo "Score: $SCORE / $TOTAL"
echo "$REWARD" > "$REWARD_FILE"
