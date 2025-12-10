#!/bin/sh

while true; do
  printf "You sure your . md contains right info about the exercises?  [y/n]: "
  read conf
  case "$conf" in
  y | yes | n | no) break ;;
  *) echo "Dear user, enter either 'y' or 'n'" ;;
  esac
done

case "$conf" in
n | no)
  echo "See ya"
  exit 0
  ;;
esac

file="README.md"

# Find the table automatically
start_line=$(grep -n '| Aufgabe' "$file" | head -1 | cut -d: -f1)

if [ -z "$start_line" ]; then
  echo "ERROR: Could not find table with '| Aufgabe' in $file"
  exit 1
fi

echo "Found table at line $start_line"

noetig_col=-1
header_found=0
table_started=0

# Use file descriptor 3 for user input
exec 3<&0

sed -n "${start_line},\$p" "$file" | while IFS= read -r line; do
  # Skip empty lines before table starts
  if [ "$table_started" -eq 0 ]; then
    if [ -z "$line" ]; then
      continue
    fi
    # Check if this is a table line
    case "$line" in
    \|*) table_started=1 ;;
    *) continue ;;
    esac
  fi

  # Stop if we hit an empty line or non-table line AFTER table started
  case "$line" in
  \|*) ;;
  *)
    if [ -z "$line" ]; then
      continue # Allow empty lines within table
    fi
    break # Stop at non-table content
    ;;
  esac

  # Skip separator line (|---|---|)
  if echo "$line" | grep -qE '^\|[[:space:]:\|-]+$'; then
    continue
  fi

  # Parse columns
  old_IFS="$IFS"
  IFS='|'
  set -- $line
  IFS="$old_IFS"

  # Clean up columns (remove empty and trim)
  cols=""
  col_count=0
  for col in "$@"; do
    # Trim spaces
    trimmed=$(echo "$col" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    if [ -n "$trimmed" ]; then
      if [ -z "$cols" ]; then
        cols="$trimmed"
      else
        cols="$cols|$trimmed"
      fi
      col_count=$((col_count + 1))
    fi
  done

  # First row is header - find "Code noetig" column
  if [ "$header_found" -eq 0 ]; then
    i=1
    old_IFS="$IFS"
    IFS='|'
    for col in $cols; do
      col_lower=$(echo "$col" | tr '[:upper:]' '[:lower:]')
      if [ "$col_lower" = "code noetig" ]; then
        noetig_col=$i
      fi
      i=$((i + 1))
    done
    IFS="$old_IFS"
    header_found=1
    continue
  fi

  # Extract columns by position
  i=1
  aufgabe_num=""
  noetig_value=""
  old_IFS="$IFS"
  IFS='|'
  for col in $cols; do
    if [ $i -eq 1 ]; then
      aufgabe_num="$col"
    fi
    if [ $i -eq "$noetig_col" ]; then
      noetig_value=$(echo "$col" | tr '[:upper:]' '[:lower:]')
    fi
    i=$((i + 1))
  done
  IFS="$old_IFS"

  # Check data rows:  if Code noetig column is "y"
  if [ "$noetig_value" = "y" ]; then
    echo "Aufgabe $aufgabe_num has 'y' in Code noetig"

    mkdir -p "src/java/progra25/aufgabe${aufgabe_num}"

    while true; do
      printf "Java File für Aufgabe %s automatisch erstellen? [y/n]: " "$aufgabe_num"
      read auto <&3 # ← Read from file descriptor 3 (original stdin)
      case "$auto" in
      y | yes | n | no) break ;;
      *) echo "Dear user, enter either 'y' or 'n'" ;;
      esac
    done

    case "$auto" in
    y | yes)
      printf "Give the list of the class names that need to be created (separated with <space>): "
      read class_names <&3 # ← Read from file descriptor 3

      for n in $class_names; do
        cat >"src/java/progra25/aufgabe${aufgabe_num}/${n}.java" <<EOF
package progra25.aufgabe${aufgabe_num};

public class ${n} {
    // Paste your content here
}
EOF
        echo "✓ Created:  src/java/progra25/aufgabe${aufgabe_num}/${n}.java"
      done
      ;;
    esac

  fi
done

echo ""
echo "You better go and paste the project structure!"
echo ""
echo "Finished processing exercises."
