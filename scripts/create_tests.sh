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
    
    if [ -z "$java_files" ]; then
        echo "Skipping $aufgabe_name (no Java files)"
        continue
    fi
    
    echo "---"
    echo "Found $aufgabe_name"
    echo "Classes:"
    
    # List classes
    for java_file in $java_files; do
        class_name=$(basename "$java_file" .java)
        echo "  - $class_name"
    done
    
    # Ask if user wants to create tests
    while true; do
        printf "Create tests for $aufgabe_name? [y/n]: "
        read answer <&3
        case "$answer" in
            y|yes) break ;;
            n|no) 
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
        cat > "$test_file" << EOF
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
done

echo ""
echo "=== Test Creation Complete ==="

