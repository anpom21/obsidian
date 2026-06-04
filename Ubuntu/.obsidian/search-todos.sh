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
VAULT_NAME=""
VAULT_PATH=""

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
    --help)
      echo "Usage: $0 [--tag TAG1,TAG2,...] [--note NOTE1,NOTE2,...] [--vault VAULT_NAME]"
      echo ""
      echo "Options:"
      echo "  --tag TAG1,TAG2,...     Filter TODOs by comma-separated tags"
      echo "  --note NOTE1,NOTE2,...  Filter TODOs in comma-separated notes"
      echo "  --vault VAULT_NAME      Specify vault name (if multiple vaults)"
      echo "  --vault-path PATH       Specify absolute path to vault directory (preferred if name fails)"
      echo "  --help                  Show this help message"
      echo ""
      echo "Examples:"
      echo "  $0                                              # All TODOs"
      echo "  $0 --tag work,robotics                         # TODOs with work or robotics tags"
      echo "  $0 --note aris sync,aris Sort                  # TODOs in specific notes"
      echo "  $0 --tag home --note projects                  # Combined filters"
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Check if Obsidian CLI is available
if ! command -v obsidian &> /dev/null; then
  echo -e "${RED}Error: obsidian CLI not found. Please install it first.${NC}"
  exit 1
fi

# Check if Obsidian is running, if not start it
if ! pgrep -x "obsidian" > /dev/null; then
  echo -e "${YELLOW}Obsidian not running. Launching...${NC}"
  obsidian &
  sleep 2
fi

# Build the base search query for TODOs
VAULT_PARAM=""
if [ -n "$VAULT_NAME" ]; then
  VAULT_PARAM="vault=\"$VAULT_NAME\""
fi

# Default vault path: directory containing this script (useful when script is inside your vault)
if [ -z "$VAULT_PATH" ]; then
  SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
  VAULT_PATH="$SCRIPT_DIR"
fi

# Helper: run obsidian search inside vault path (if provided) or with vault param
obsidian_search() {
  # args passed as-is
  if [ -n "$VAULT_PATH" ] && [ -d "$VAULT_PATH" ]; then
    (cd "$VAULT_PATH" && obsidian search:context "$@")
  elif [ -n "$VAULT_PARAM" ]; then
    obsidian $VAULT_PARAM search:context "$@"
  else
    obsidian search:context "$@"
  fi
}

# Fallback: grep-based search when obsidian CLI fails or vault inaccessible
grep_search_todos_in_files() {
  search_path="$1"
  shift
  # search for literal '- [ ]' in markdown files
  find "$search_path" -type f -name "*.md" -print0 | xargs -0 grep -nH -- "- \[ \]" || true
}

# Search for all TODOs
echo -e "${BLUE}Searching for TODOs...${NC}\n"

# If we have tags, search for them
if [ ${#TAGS[@]} -gt 0 ]; then
  echo -e "${BLUE}Filtering by tags: ${TAGS[*]}${NC}\n"
  
  for tag in "${TAGS[@]}"; do
    # Trim whitespace
    tag=$(echo "$tag" | xargs)
    echo -e "${YELLOW}TODOs with tag: #${tag}${NC}"
    
    # try obsidian first, fall back to grep
    if obsidian_search query="- \[ \]" 2>&1 | tee /tmp/obsidian_search.out | grep -qi "vault not found\|error"; then
      grep_search_todos_in_files "$VAULT_PATH" | grep -i "#${tag}" | head -20
    else
      cat /tmp/obsidian_search.out | grep -i "#${tag}" | head -20
    fi
    echo ""
  done
fi

# If we have notes, search in those specific notes
if [ ${#NOTES[@]} -gt 0 ]; then
  echo -e "${BLUE}Filtering by notes: ${NOTES[*]}${NC}\n"
  
  for note in "${NOTES[@]}"; do
    # Trim whitespace
    note=$(echo "$note" | xargs)
    echo -e "${YELLOW}TODOs in note: [[${note}]]${NC}"
    
    # For notes, try obsidian first. If it fails, look for files that contain [[note]] or have matching filename
    if obsidian_search query="- \[ \]" path="$note" 2>/dev/null | tee /tmp/obsidian_search.out | grep -qi "vault not found\|error"; then
      # obsidian failed -> grep fallback
      # find files that contain the link [[note]] (case-insensitive) or filename matches
      files=$(find "$VAULT_PATH" -type f -name "*.md" -print0 | xargs -0 -I{} sh -c 'grep -qi "\[\[${0}\]\]" "{}" && printf "%s\n" "{}"' "$note" 2>/dev/null || true)
      # also add files whose basename matches the note
      while IFS= read -r f; do :; done < <(printf "%s\n" "$files")
      if [ -z "$files" ]; then
        # try filename match
        files=$(find "$VAULT_PATH" -type f -iname "${note}.md" 2>/dev/null || true)
      fi
      if [ -n "$files" ]; then
        echo "$files" | xargs -r grep -nH -- "- \[ \]" | head -20
      else
        echo "(no matching files for note: $note)"
      fi
    else
      cat /tmp/obsidian_search.out | grep -i "$note" | head -20
    fi
    echo ""
  done
fi

# If no filters, show all TODOs
if [ ${#TAGS[@]} -eq 0 ] && [ ${#NOTES[@]} -eq 0 ]; then
  echo -e "${YELLOW}All TODOs in vault:${NC}\n"
  
  # try obsidian; if it reports vault errors use grep fallback
  if obsidian_search query="- \[ \]" limit=50 2>&1 | tee /tmp/obsidian_search.out | grep -qi "vault not found\|error"; then
    grep_search_todos_in_files "$VAULT_PATH" | head -100
  else
    cat /tmp/obsidian_search.out
  fi
fi

echo -e "\n${GREEN}Search complete!${NC}"
