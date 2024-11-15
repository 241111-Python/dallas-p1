#!/bin/bash

echo -n "Please give an input: "
read -r input

START=$(date +%s%3N)

count=0

sqrt=$(awk "BEGIN {print int(sqrt($input))}")

for (( i = 2; i < sqrt; i++ )); do
    if (( input % i == 0 )); then
        echo "$input is not prime because it's divisible by $i"
        count=$((count + 1))
        break
    fi
done

if (( count == 0 )); then
    echo "$input is prime!"
fi

END=$(date +%s%3N)

diff=$((END - START))

seconds=$((diff / 1000))
milliseconds=$((diff % 1000))

echo "${input}, ${seconds}.${milliseconds}" >> ./results.txt
