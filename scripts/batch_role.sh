#!/bin/bash

# Check if the user has provided an input file
if [ $# -eq 0 ]; then
  echo "Error: No input file provided."
  exit 1
fi

# Read the input file line by line
while read email; do
  # Skip empty lines
  if [ -z "$email" ]; then
    continue
  fi

  # Execute the command for each email address in the list
  invenio roles add $email community-manager
done < $1