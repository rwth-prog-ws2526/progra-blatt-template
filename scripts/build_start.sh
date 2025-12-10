#!/bin/sh

# Compile all exercises automatically

# Check if bin directory exists, create if not
mkdir -p bin

# Find JUnit JAR
junit_jar=$(find .tools -name "junit-platform-console-standalone*. jar" 2>/dev/null | head -1)

if [ -z "$junit_jar" ]; then
  echo "JUnit .jar wasn't found, downloading it right now..."
  ./scripts/download.sh
fi

echo "=== Compiling all exercises ==="
echo ""

# Counter for statistics
total=0
success=0
failed=0

# Find all aufgabe directories
for aufgabe_dir in src/java/progra25/aufgabe*/; do
  # Check if directory exists and has Java files
  if [ ! -d "$aufgabe_dir" ]; then
    continue
  fi

  # Check if there are any . java files
  if [ -z "$(ls ${aufgabe_dir}*.java 2>/dev/null)" ]; then
    continue
  fi

  # Extract aufgabe number (e.g., aufgabe01 -> 01)
  aufgabe_name=$(basename "$aufgabe_dir")
  aufgabe_num=$(echo "$aufgabe_name" | sed 's/aufgabe//')

  total=$((total + 1))

  echo "---"
  echo "Compiling $aufgabe_name..."

  # Check if tests exist
  test_dir="tests/java/progra25/aufgabe${aufgabe_num}"
  has_tests=0

  if [ -d "$test_dir" ] && [ -n "$(ls ${test_dir}/*. java 2>/dev/null)" ]; then
    has_tests=1
  fi

  # Compile
  if [ $has_tests -eq 1 ] && [ -n "$junit_jar" ]; then
    # Compile with tests
    echo "  → Compiling sources and tests..."
    if javac -d bin \
      -cp "$junit_jar" \
      "${aufgabe_dir}"*. java \
      "${test_dir}/"*.java 2>&1; then
      echo "  ✓ Success (with tests)"
      success=$((success + 1))
    else
      echo "  ✗ Failed"
      failed=$((failed + 1))
    fi
  else
    # Compile without tests
    echo "  → Compiling sources only..."
    if javac -d bin \
      "${aufgabe_dir}"*.java 2>&1; then
      echo "  ✓ Success"
      success=$((success + 1))
    else
      echo "  ✗ Failed"
      failed=$((failed + 1))
    fi
  fi
done

echo ""
echo "=== Compilation Summary ==="
echo "Total:    $total"
echo "Success:  $success"
echo "Failed:   $failed"

if [ $failed -gt 0 ]; then
  exit 1
fi

echo ""
while true; do
  printf "Create test files now? [y/n]: "
  read create_tests <&3
  case "$create_tests" in
  y | yes)
    sh ./scripts/create_tests.sh
    break
    ;;
  n | no)
    echo "You can create tests later with: ./scripts/create_tests. sh"
    break
    ;;
  *) echo "Please enter 'y' or 'n'" ;;
  esac
done
