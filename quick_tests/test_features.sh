#!/bin/bash
set -euo pipefail

# test_features.sh - Additional test cases for WebX language features
# This script runs a series of tests to ensure various WebX features are working correctly

# Credits: This project is a fork of KDX (KodPix) by Yug Merabtene, adapted by Samy Alderson

# Check if WebX compiler is built and available
if [ ! -f "../build/webx" ]; then
  echo "Error: WebX compiler not found. Run 'build.sh' to build it."
  exit 1
fi

# Define test cases
TEST_CASES=(
  "test_class_definition"
  "test_function_call"
  "test_variable_declaration"
  "test_control_flow"
  "test_string_manipulation"
)

# Run each test case
for test_case in "${TEST_CASES[@]}"; do
  echo "Running test case: $test_case"
  ../build/webx -f "quick_tests/$test_case.webx" -o "quick_tests/$test_case.html"
  if [ $? -ne 0 ]; then
    echo "Error: Test case '$test_case' failed."
    exit 1
  fi
done

# This was tricky, but we need to check the generated HTML files for correctness
for test_case in "${TEST_CASES[@]}"; do
  echo "Verifying generated HTML for test case: $test_case"
  if ! grep -q "<html>" "quick_tests/$test_case.html"; then
    echo "Error: Generated HTML for test case '$test_case' is invalid."
    exit 1
  fi
done

echo "All test cases passed."