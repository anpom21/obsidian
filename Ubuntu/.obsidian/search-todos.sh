#!/bin/bash

# Obsidian TODO Search Script
# Searches for TODOs with optional tag and note filtering
# Usage: ./search-todos.sh [--tag TAG1,TAG2,...] [--note NOTE1,NOTE2,...]
# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Initialize variables
TAGS=()
NOTES=()
STRING_SEARCH=""
CASE_SENSITIVE=0
VAULT_NAME=""
VAULT_PATH="/home/ap/Documents/obsidian/Ubuntu"

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --tag)
      IFS=',' read -ra TAGS <<< "$2"
      shift 2
      ;;
    --note)
      IFS=',' read -ra NOTES <<< "$2"
      shift 2
      ;;
    --vault)
      VAULT_NAME="$2"
      shift 2
      ;;
    --vault-path)
      VAULT_PATH="$2"
      shift 2
      ;;
    --string)
      STRING_SEARCH="$2"
      shift 2
      ;;
    --case)
      CASE_SENSITIVE=1
      shift
      ;;
    --help)
      echo "Usage: $0 [--tag TAG1,TAG2,...] [--note NOTE1,NOTE2,...] [--string TEXT] [--case] [--vault VAULT_NAME]"
      echo ""
      echo "Options:"
      echo "  --tag TAG1,TAG2,...     Filter TODOs by comma-separated tags"
      echo "  --note NOTE1,NOTE2,...  Filter TODOs in comma-separated notes"
      echo "  --string TEXT           Filter TODOs by substring"
      echo "  --case                  Enable case-sensitive matching (default is case-insensitive)"
      echo "  --vault VAULT_NAME      Specify vault name (if multiple vaults)"
      echo "  --vault-path PATH       Specify absolute path to vault directory (preferred if name fails)"
      echo "  --help                  Show this help message"
      echo ""
      echo "Examples:"
      echo "  $0                                              # All TODOs"
      echo "  $0 --tag work,robotics                         # TODOs with work or robotics tags"
      echo "  $0 --note aris sync,aris Sort                  # TODOs in specific notes"
      echo "  $0 --string report                            # TODOs that include a substring"
      echo "  $0 --string report --case                      # Case-sensitive substring match"
      echo "  $0 --tag home --note projects                  # Combined filters"
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Check if fd and rg are available
if ! command -v fd &> /dev/null; then
  echo -e "${RED}Error: fd not found. Please install it first.${NC}"
  exit 1
fi
if ! command -v rg &> /dev/null; then
  echo -e "${RED}Error: rg (ripgrep) not found. Please install it first.${NC}"
  exit 1
fi

# Default vault path: parent of this script (when script lives in .obsidian)
if [ -z "$VAULT_PATH" ]; then
  SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
  VAULT_PATH="$(cd "$SCRIPT_DIR/.." && pwd)"
fi

get_all_md_files() {
  fd -t f -e md . "$VAULT_PATH"
}

filter_files_by_note_mentions() {
  local current_files
  current_files="$1"
  local note="$2"
  if [ -z "$current_files" ]; then
    get_all_md_files | xargs -d '\n' -r rg -l ${RG_CASE_FLAGS} --fixed-strings -- "[[${note}]]"
  else
    printf "%s\n" "$current_files" | xargs -d '\n' -r rg -l ${RG_CASE_FLAGS} --fixed-strings -- "[[${note}]]"
  fi
}

line_has_all_tags() {
  local line="$1"
  shift
  local tag
  for tag in "$@"; do
    if ! printf "%s" "$line" | rg -q ${RG_CASE_FLAGS} --fixed-strings "#${tag}"; then
      return 1
    fi
  done
  return 0
}

line_has_all_notes() {
  local line="$1"
  shift
  local note
  for note in "$@"; do
    if ! printf "%s" "$line" | rg -q ${RG_CASE_FLAGS} --fixed-strings "[[${note}]]"; then
      return 1
    fi
  done
  return 0
}

line_has_string() {
  local line="$1"
  local text="$2"
  if [ -z "$text" ]; then
    return 0
  fi
  if ! printf "%s" "$line" | rg -q ${RG_CASE_FLAGS} --fixed-strings "$text"; then
    return 1
  fi
  return 0
}

if [ $CASE_SENSITIVE -eq 1 ]; then
  RG_CASE_FLAGS=""
else
  RG_CASE_FLAGS="-i"
fi

for i in "${!TAGS[@]}"; do
  TAGS[$i]=$(echo "${TAGS[$i]}" | xargs)
done
for i in "${!NOTES[@]}"; do
  NOTES[$i]=$(echo "${NOTES[$i]}" | xargs)
done

matching_files=""
if [ ${#NOTES[@]} -gt 0 ]; then
  for note in "${NOTES[@]}"; do
    matching_files=$(filter_files_by_note_mentions "$matching_files" "$note")
  done
else
  matching_files=$(get_all_md_files)
fi

if [ -z "$matching_files" ]; then
  exit 0
fi

printf "%s\n" "$matching_files" | xargs -d '\n' -r rg -n --with-filename ${RG_CASE_FLAGS} --fixed-strings -- "- [ ]" | while IFS= read -r line; do
  if line_has_all_tags "$line" "${TAGS[@]}" && line_has_all_notes "$line" "${NOTES[@]}" && line_has_string "$line" "$STRING_SEARCH"; then
    echo "$line"
  fi
done
