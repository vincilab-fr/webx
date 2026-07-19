#!/bin/bash -euo pipefail

# test_features.sh

# Set up test directory
TEST_DIR=$(mktemp -d)

# Create test files
cat > ${TEST_DIR}/test_functions.webx <<EOF
fn add(a: i32, b: i32) -> i32 {
  return a + b;
}

fn main() -> i32 {
  println("Hello, World!");
  let result = add(2, 3);
  println(result);
  return result;
}
EOF

cat > ${TEST_DIR}/test_let.webx <<EOF
fn main() -> i32 {
  let x = 5;
  let y = 10;
  println(x);
  println(y);
  return x + y;
}
EOF

cat > ${TEST_DIR}/test_if.webx <<EOF
fn main() -> i32 {
  if true {
    println("It's true!");
  } else {
    println("It's false!");
  }
  return 0;
}
EOF

cat > ${TEST_DIR}/test_while.webx <<EOF
fn main() -> i32 {
  let x = 0;
  while x < 5 {
    println(x);
    x = x + 1;
  }
  return 0;
}
EOF

# Build WebX
./build.sh ${TEST_DIR}/test_functions.webx ${TEST_DIR}/test_let.webx ${TEST_DIR}/test_if.webx ${TEST_DIR}/test_while.webx

# Run tests
./test.sh ${TEST_DIR}

# Clean up
rm -rf ${TEST_DIR}

echo "Feature tests passed!"