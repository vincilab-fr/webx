#!/bin/bash

set -euo pipefail

# this script is for additional test cases for WebX language features
# credit to Yug Merabtene for the original KDX project

# check if we're in the right directory
if [ ! -f "build.sh" ]; then
  echo "error: must run from the project root" >&2
  exit 1
fi

# run a single test
run_test() {
  local test_name="$1"
  local test_file="quick_tests/$test_name.webx"
  if [ ! -f "$test_file" ]; then
    echo "error: test file not found: $test_file" >&2
    return 1
  fi

  # compile the test
  ./build.sh "$test_file"

  # run the compiled test
  local output_file="${test_name%.webx}.out"
  ./quick_tests/"$test_name" > "$output_file"

  # check the output
  local expected_file="${test_name%.webx}.expected"
  if [ -f "$expected_file" ]; then
    diff -u "$expected_file" "$output_file"
    if [ $? -ne 0 ]; then
      echo "error: test failed: $test_name" >&2
      return 1
    fi
  fi
}

# run all tests
for test_file in quick_tests/*.webx; do
  local test_name="${test_file##*/}"
  test_name="${test_name%.webx}"
  echo "running test: $test_name"
  if ! run_test "$test_name"; then
    exit 1
  fi
done

echo "all tests passed"