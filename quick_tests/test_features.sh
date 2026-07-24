#!/bin/bash

set -euo pipefail

echo "Running quick tests on WebX compiler features"

# Test if/else statement
echo "Testing if/else statement"
nasm -f elf64 -o test_if.o src/main.asm -DTEST_IF=1
ld -m elf_x86-64 test_if.o -o test_if
./test_if

# Test let statement
echo "Testing let statement"
nasm -f elf64 -o test_let.o src/main.asm -DTEST_LET=1
ld -m elf_x86-64 test_let.o -o test_let
./test_let

# Test return statement
echo "Testing return statement"
nasm -f elf64 -o test_return.o src/main.asm -DTEST_RETURN=1
ld -m elf_x86-64 test_return.o -o test_return
./test_return

# Test while statement
echo "Testing while statement"
nasm -f elf64 -o test_while.o src/main.asm -DTEST_WHILE=1
ld -m elf_x86-64 test_while.o -o test_while
./test_while

echo "All tests passed"