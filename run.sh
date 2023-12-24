#!/bin/bash

entry=$(echo "$1" | tr a-z A-Z)

if [ ${#entry} -ne 1 ]; then
    echo 'Error: Enter a problem entry.'
    exit 1
fi

dune build # NOTE: Build first so that the test run time does not include the build time.

# NOTE:
# Only for problem C, the solution is not unique,
# so it is necessary to check whether the solution is correct using the special checker.
if [ ${entry} = "C" ]; then
    project_root=$(pwd)

    cd judgedata/C
    c++ output_checker.cpp >/dev/null 2>&1 # NOTE: Assume that the execution environment is macOS.

    for problem in ${entry}?; do
        time dune exec icpc_domestic2023 c <${problem} >${problem}.out
        ./a.out ${problem} ${problem}.out ${problem}.ans
    done

    cd $project_root
    exit
fi

for problem in "judgedata/${entry}/${entry}"?; do
    time diff ${problem}.ans <(dune exec icpc_domestic2023 $(echo $entry | tr A-Z a-z) <${problem})
done
