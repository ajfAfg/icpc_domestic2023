#!/bin/bash

entry=$(echo "$1" | tr a-z A-Z)

if [ ${#entry} -ne 1 ]; then
    echo 'Error: Enter a problem entry.'
    exit 1
fi

dune build # NOTE: Build first so that the test run time does not include the build time.

for problem in "judgedata/${entry}/${entry}"?; do
    time diff ${problem}.ans <(dune exec icpc_domestic2023 $(echo $entry | tr A-Z a-z) <${problem})
done
