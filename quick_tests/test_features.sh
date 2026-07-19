#!/bin/bash

set -euo pipefail

# this was tricky, needed to handle errors properly
test_features() {
  local test_name=$1
  local input_file=$2
  local expected_output_file=$3

  # run the compiler
  ./webx -o /dev/null "$input_file" || { echo "compilation failed for $test_name"; return 1; }

  # run the generated code
  local output
  output=$("$input_file" 2>&1) || { echo "execution failed for $test_name"; return 1; }

  # compare with expected output
  if [ "$output" != "$(cat "$expected_output_file")" ]; then
    echo "output mismatch for $test_name"
    return 1
  fi
}

# test language features
test_features "variables" "quick_tests/variables.webx" "quick_tests/variables.txt"
test_features "control_flow" "quick_tests/control_flow.webx" "quick_tests/control_flow.txt"
test_features "functions" "quick_tests/functions.webx" "quick_tests/functions.txt"
test_features "classes" "quick_tests/classes.webx" "quick_tests/classes.txt"

# not proud of this but it works
if [ $? -eq 0 ]; then
  echo "all tests passed"
else
  echo "some tests failed"
  exit 1
fi