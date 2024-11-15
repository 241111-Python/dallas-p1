#!/bin/bash

SCRIPT_PATH=$(realpath "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
cd "$SCRIPT_DIR" || exit 1

FILE="./results.csv"
OUTPUT="./results2.txt"

min=10000000
minTime=10000000
max=0
maxTime=0
count=0
totalTime=0

while IFS=, read -r col1 col2; do
    wholePart=${col2%.*}
    fractionalPart=${col2#*.}
    fractionalPart=${fractionalPart:-0}
    timeInMs=$(( wholePart * 1000 + fractionalPart * 10 ))

    count=$((count + 1))
    totalTime=$((totalTime + timeInMs))

    if (( timeInMs < minTime )); then
        min=$col1
        minTime=$timeInMs
    fi
    if (( timeInMs > maxTime )); then
        max=$col1
        maxTime=$timeInMs
    fi
done < "$FILE"

if (( count > 0 )); then
    averageTimeMs=$((totalTime / count))
else
    echo "No data to process" >> "$OUTPUT"
    exit 1
fi

echo "The quickest execution was for ${min} at ${minTime} ms" >> "$OUTPUT"
echo "The slowest execution was for ${max} at ${maxTime} ms" >> "$OUTPUT"
echo "The average execution time was ${averageTimeMs} ms" >> "$OUTPUT"
