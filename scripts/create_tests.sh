#!/bin/sh

# Automatically create test files for exercises

# Use file descriptor 3 for user input
exec 3<&0

echo "=== Create Test Files ==="
echo ""

# Find all aufgabe directories
for aufgabe_dir in src/java/progra25/aufgabe*/; do
  # Skip if not a directory
  [ -d "$aufgabe_dir" ] || continue

  # Extract aufgabe info
  aufgabe_name=$(basename "$aufgabe_dir")
  aufgabe_num=$(echo "$aufgabe_name" | sed 's/aufgabe//')

  # Get list of Java classes in aufgabe
  java_files=$(ls "${aufgabe_dir}"*.java 2>/dev/null)

  # Get list of Haskell files in aufgabe
  haskell_files=$(ls "${aufgabe_dir}"*.hs && ls "${aufgabe_dir}"*.lhs 2>/dev/null) #Only works with .hs and .lhs

  # Get list of Prolog files in aufgabe
  prolog_files=$(ls "${aufgabe_dir}"*.pl 2>/dev/null)

  echo "Processing Java Files..."

  if [ -z "$java_files" ]; then
    echo "Skipping $aufgabe_name (no Java files)"
    continue
  fi

  echo "---"
  echo "Found a Java Project $aufgabe_name"
  echo "Classes:"

  # List classes
  for java_file in $java_files; do
    class_name=$(basename "$java_file" .java)
    echo "  - $class_name"
  done

  # Ask if user wants to create Java tests
  while true; do
    printf "Create Java tests for $aufgabe_name? [y/n]: "
    read answer <&3
    case "$answer" in
    y | yes) break ;;
    n | no)
      echo "Skipping $aufgabe_name"
      continue 2
      ;;
    *) echo "Please enter 'y' or 'n'" ;;
    esac
  done

  # Create test directory
  test_dir="tests/java/progra25/aufgabe${aufgabe_num}"
  mkdir -p "$test_dir"

  # Ask which classes to test
  printf "Which classes to test? (space-separated, or 'all'): "
  read classes_to_test <&3

  if [ "$classes_to_test" = "all" ]; then
    classes_to_test=""
    for java_file in $java_files; do
      class_name=$(basename "$java_file" .java)
      classes_to_test="$classes_to_test $class_name"
    done
  fi

  # Create test files
  for class_name in $classes_to_test; do
    test_file="${test_dir}/${class_name}Test.java"

    if [ -f "$test_file" ]; then
      echo "  ⚠ ${class_name}Test.java already exists, skipping"
      continue
    fi

    # Create test template
    cat >"$test_file" <<EOF
package progra25.aufgabe${aufgabe_num};

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import org. junit.jupiter.api.AfterEach;
import static org.junit.jupiter.api. Assertions.*;

/**
 * Test class for ${class_name}
 */
public class ${class_name}Test {
    
    private ${class_name} instance;
    
    @BeforeEach
    public void setUp() {
        // Initialize test instance
        instance = new ${class_name}();
    }
    
    @AfterEach
    public void tearDown() {
        instance = null;
    }
    
    @Test
    public void testExample() {
        // TODO: Implement test
        fail("Test not yet implemented");
    }
    
    @Test
    public void testEdgeCase() {
        // TODO: Test edge cases
        fail("Test not yet implemented");
    }
}
EOF

    echo "  ✓ Created ${class_name}Test.java"
  done
  echo "Processing Java Files..."

  if [ -z "$java_files" ]; then
    echo "Skipping $aufgabe_name (no Java files)"
    continue
  fi

  echo "---"
  echo "Found a Java Project $aufgabe_name"
  echo "Classes:"

  # List classes
  for java_file in $java_files; do
    class_name=$(basename "$java_file" .java)
    echo "  - $class_name"
  done

  # Ask if user wants to create Java tests
  while true; do
    printf "Create Java tests for $aufgabe_name? [y/n]: "
    read answer <&3
    case "$answer" in
    y | yes) break ;;
    n | no)
      echo "Skipping $aufgabe_name"
      continue 2
      ;;
    *) echo "Please enter 'y' or 'n'" ;;
    esac
  done

  # Create test directory
  test_dir="tests/java/progra25/aufgabe${aufgabe_num}"
  mkdir -p "$test_dir"

  # Ask which classes to test
  printf "Which classes to test? (space-separated, or 'all'): "
  read classes_to_test <&3

  if [ "$classes_to_test" = "all" ]; then
    classes_to_test=""
    for java_file in $java_files; do
      class_name=$(basename "$java_file" .java)
      classes_to_test="$classes_to_test $class_name"
    done
  fi

  # Create test files
  for class_name in $classes_to_test; do
    test_file="${test_dir}/${class_name}Test.java"

    if [ -f "$test_file" ]; then
      echo "  ⚠ ${class_name}Test.java already exists, skipping"
      continue
    fi

    # Create test template
    cat >"$test_file" <<EOF
package progra25.aufgabe${aufgabe_num};

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import org. junit.jupiter.api.AfterEach;
import static org.junit.jupiter.api. Assertions.*;

/**
 * Test class for ${class_name}
 */
public class ${class_name}Test {
    
    private ${class_name} instance;
    
    @BeforeEach
    public void setUp() {
        // Initialize test instance
        instance = new ${class_name}();
    }
    
    @AfterEach
    public void tearDown() {
        instance = null;
    }
    
    @Test
    public void testExample() {
        // TODO: Implement test
        fail("Test not yet implemented");
    }
    
    @Test
    public void testEdgeCase() {
        // TODO: Test edge cases
        fail("Test not yet implemented");
    }
}
EOF

    echo "  ✓ Created ${class_name}Test.java"
  done

  echo "Processing Haskell Files..."

  if [ -z "$haskell_files" ]; then
    echo "Skipping $aufgabe_name (no Haskell files)"
    continue
  fi

  echo "---"
  echo "Found a Haskell Project $aufgabe_name"
  echo "Files:"

  # List classes
  for haskell_file in $haskell_files; do
    class_name=$(basename "$haskell_file" .java)
    echo "  - $class_name"
  done

  # Ask if user wants to create Java tests
  while true; do
    printf "Create Haskell tests for $aufgabe_name? [y/n]: "
    read answer <&3
    case "$answer" in
    y | yes) break ;;
    n | no)
      echo "Skipping $aufgabe_name"
      continue 2
      ;;
    *) echo "Please enter 'y' or 'n'" ;;
    esac
  done

  # Create test directory
  test_dir="tests/haskell/progra25/aufgabe${aufgabe_num}"
  mkdir -p "$test_dir"

  # Ask which files to test
  printf "Which files to test? (space-separated, or 'all'): "
  read classes_to_test <&3

  if [ "$classes_to_test" = "all" ]; then
    files_to_test=""
    for haskell_file in $haskell_files; do
      file_name=$(basename "$haskell_file" .hs)
      files_to_test="$files_to_test $file_name"
    done
  fi

  # Create test files
  for file_name in $files_to_test; do
    test_file="${test_dir}/${file_name}Test.hs"

    if [ -f "$test_file" ]; then
      echo "  ⚠ ${file_name}Test.hs already exists, skipping"
      continue
    fi

    # Create test template
    cat >"$test_file" <<EOF
module ${file_name} where

import Test.HUnit

-- That's only a template
-- Simple Assertions
testEqual   = TestCase (assertEqual "Should be 5" 5 (2 + 3))
testTrue    = TestCase (assertBool "Should be True" (null []))
testFailure = TestCase (assertFailure "Force a failure here")

-- Grouping Tests (The List)
-- Use ~: to give a test a label, and ~== to shortcut assertEqual
-- don't forget to manually update it!
${file_name}tests = TestList 
    [ "Math Test"    ~: 4 ~== (2 * 2)
    , "Logic Test"   ~: True ~=? (1 < 2)
    , "String Test"  ~: "haskell" ~=? "haskell"
    , "Manual Label" ~: testEqual
    ]
EOF

    echo "  ✓ Created ${class_name}Test.hs"
  done

done

echo ""
echo "=== Test Creation Complete ==="
