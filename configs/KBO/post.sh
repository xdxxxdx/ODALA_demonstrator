#!/bin/bash

# Set the endpoint URL
endpoint_url="http://localhost:8080/kbo"

# Set the Content-Type header
content_type="application/turtle"

# Iterate through files in the /kbo folder
for file in bel20/*; do
    # Check if the file is a regular file
    if [ -f "$file" ]; then
        # Use curl to send the file to the endpoint with the specified header
        curl -X POST -H "Content-Type: $content_type" --data-binary "@$file" "$endpoint_url"
        # Optionally, you can add a newline for better readability between file uploads
        echo
    fi
done
