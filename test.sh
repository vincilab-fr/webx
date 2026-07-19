#!/bin/bash
set -euo pipefail

expect_failure() {
  local expected_code="$1"
  shift

  set +e
  "$@" >/tmp/kdx_test.stderr 2>&1
  local actual_code=$?
  set -e

  if [[ $actual_code -ne $expected_code ]]; then
    echo "Expected exit code $expected_code, got $actual_code for: $*"
    cat /tmp/kdx_test.stderr
    exit 1
  fi
}

expect_program_exit() {
  local expected_code="$1"
  shift

  set +e
  "$@" >/tmp/kdx_test.stderr 2>&1
  local actual_code=$?
  set -e

  if [[ $actual_code -ne $expected_code ]]; then
    echo "Expected program exit $expected_code, got $actual_code for: $*"
    cat /tmp/kdx_test.stderr
    exit 1
  fi
}

cleanup_artifacts() {
  rm -f ci_out.s ci_out.o ci_out_bin ci_hello.s ci_hello_bin ci_flow.s ci_v2_types.s ci_v2_inc.s ci_big.webx ci_bad_syntax.webx ci_bad_token.webx ci_bad_call_paren.webx ci_bad_for_header.webx ci_hello_custom /tmp/kdx_test.stderr
}

trap cleanup_artifacts EXIT

echo "Testing KodPix compiler..."

./build.sh

cleanup_artifacts

echo "[1/20] Help output"
./kdx --help >/dev/null

echo "[2/20] Assembly-only mode"
./kdx examples/simple.webx -S -o ci_out.s
test -f ci_out.s

echo "[3/20] Compile-only mode"
./kdx examples/simple.webx -c -o ci_out.o
test -f ci_out.o

echo "[4/20] Full compile and run"
./kdx examples/simple.webx -o ci_out_bin
test -f ci_out_bin

echo "[5/20] Hello sample (typed return + call syntax)"
./kdx examples/hello.webx -S -o ci_hello.s
test -f ci_hello.s
./kdx examples/hello.webx -o ci_hello_bin
test -f ci_hello_bin
chmod +x ci_hello_bin
./ci_hello_bin

echo "[6/20] Control-flow sample emits assembly"
./kdx examples/control_flow.webx -S -o ci_flow.s
test -f ci_flow.s

echo "[7/20] Typed params header compiles"
./kdx quick_tests/spec/pass/p05_typed_params_header.webx -S -o ci_v2_types.s
test -f ci_v2_types.s

echo "[8/20] V2 postfix increment parses and emits assembly"
./kdx examples/syntax_v2_increment.webx -S -o ci_v2_inc.s
test -f ci_v2_inc.s

echo "[9/20] Invalid flag returns error"
expect_failure 1 ./kdx --bad-flag

echo "[10/20] Missing input returns error"
expect_failure 1 ./kdx

echo "[11/20] Missing file returns I/O error"
expect_failure 5 ./kdx examples/does_not_exist.webx

echo "[12/20] Oversized input is rejected"
dd if=/dev/zero of=ci_big.webx bs=1 count=17000 status=none
expect_failure 5 ./kdx ci_big.webx

echo "[13/20] Incompatible flags are rejected"
expect_failure 1 ./kdx -S -x examples/simple.webx

echo "[14/20] Missing -o value is rejected"
expect_failure 1 ./kdx -o -S examples/simple.webx

echo "[15/20] Multiple input files are rejected"
expect_failure 1 ./kdx examples/simple.webx examples/hello.webx

echo "[16/20] Malformed syntax returns parser error"
cat > ci_bad_syntax.webx <<'EOF'
fn main( {
    return 0;
}
EOF
expect_failure 2 ./kdx ci_bad_syntax.webx

echo "[17/20] Unknown token returns parser error"
cat > ci_bad_token.webx <<'EOF'
fn main() -> i32 {
    @
    return 0;
}
EOF
expect_failure 2 ./kdx ci_bad_token.webx

echo "[18/20] Custom output binary path"
./kdx examples/hello.webx -o ci_hello_custom
test -f ci_hello_custom

echo "[19/20] Missing call ')' returns parser error"
cat > ci_bad_call_paren.webx <<'EOF'
fn main() -> i32 {
    println("x";
    return 0;
}
EOF
expect_failure 2 ./kdx ci_bad_call_paren.webx

echo "[20/20] Missing for-header ';' returns parser error"
cat > ci_bad_for_header.webx <<'EOF'
fn main() -> i32 {
    for (let i = 0; i < 3 i + 1) {
        return 1;
    }
    return 0;
}
EOF
expect_failure 2 ./kdx ci_bad_for_header.webx

echo "All tests passed"
