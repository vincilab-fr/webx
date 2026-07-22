#!/bin/bash

# Set up strict error handling
set -euo pipefail

# Clean up previous test results
rm -rf test_results

# Test if/else statements
cd test_cases/if_chain
echo "Testing if/else statements..."
./test.sh
if [ $? -ne 0 ]; then
  echo "Error: if/else statement test failed"
  exit 1
fi
echo "if/else statement test passed"

# Test while loop
cd test_cases/while_loop
echo "Testing while loop..."
./test.sh
if [ $? -ne 0 ]; then
  echo "Error: while loop test failed"
  exit 1
fi
echo "while loop test passed"

# Test functions
cd test_cases/functions
echo "Testing functions..."
./test.sh
if [ $? -ne 0 ]; then
  echo "Error: function test failed"
  exit 1
fi
echo "function test passed"

# Test let statements
cd test_cases/let_statements
echo "Testing let statements..."
./test.sh
if [ $? -ne 0 ]; then
  echo "Error: let statement test failed"
  exit 1
fi
echo "let statement test passed"

# Test return statements
cd test_cases/return_statements
echo "Testing return statements..."
./test.sh
if [ $? -ne 0 ]; then
  echo "Error: return statement test failed"
  exit 1
fi
echo "return statement test passed"

# Test multiple features together
cd test_cases/multiple_features
echo "Testing multiple features together..."
./test.sh
if [ $? -ne 0 ]; then
  echo "Error: multiple feature test failed"
  exit 1
fi
echo "multiple feature test passed"

# Report test results
echo "All test cases passed"