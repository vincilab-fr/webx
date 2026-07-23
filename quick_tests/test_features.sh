#!/bin/bash

# Set exit on error and unset undefined variables
set -euo pipefail

# Function to compile and run a single test
compile_and_run() {
  local file=$1
  local output=$2

  # Assemble the file
  nasm -f elf64 $file -o temp.o || echo "Failed to assemble $file"

  # Link the object file
  ld temp.o -o temp.exe || echo "Failed to link temp.o"

  # Run the executable
  ./temp.exe > $output && echo "Passed: $file" || echo "Failed: $file"
}

# Function to run a set of tests
run_test_suite() {
  local suite=$1
  local output_dir=$2

  # Create the output directory if it doesn't exist
  mkdir -p $output_dir

  # Run each test in the suite
  for file in $suite; do
    local output=$output_dir/$(basename $file .webx)
    compile_and_run $file $output
  done
}

# Run quick tests
run_test_suite "examples/*" quick_tests/quick_test_output

# Run feature tests
run_test_suite "features/*" quick_tests/feature_test_output