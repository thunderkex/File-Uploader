#!/bin/bash

# Check if a file argument is provided
if [[ "$#" -eq 0 ]]; then
    echo "ERROR: No file specified!"
    echo "Usage: $0 <file_path> [service]"
    exit 1
fi

# Store the file path
FILE="$1"
SERVICE="${2:-gofile}"  # Default to 'gofile' if no service is specified

# Function to upload to GoFile
upload_to_gofile() {
    # Query GoFile API to find the best server for upload
    SERVER=$(curl -s https://api.gofile.io/servers | jq -r '.data.servers[0].name')

    # Upload the file to GoFile and capture the response
    RESPONSE=$(curl -# -F "file=@$FILE" "https://${SERVER}.gofile.io/uploadFile")

    # Check if the upload was successful
    if [[ $? -ne 0 ]]; then
        echo "ERROR: Failed to upload the file to GoFile."
        echo "Please check your internet connection and try again."
        exit 1
    fi

    # Extract the download page URL from the response
    LINK=$(echo "$RESPONSE" | jq -r '.data.downloadPage')

    # Check if the link was successfully extracted
    if [[ "$LINK" == "null" ]]; then
        echo "ERROR: Failed to retrieve the download link from GoFile."
        echo "Response: $RESPONSE"
        exit 1
    fi

    # Display the download link
    echo "Download link from GoFile: $LINK"
}

# Determine which service to use
case "$SERVICE" in
    gofile)
        upload_to_gofile
        ;;
    *)
        echo "ERROR: Unknown service '$SERVICE'."
        echo "Available services: gofile, anotherfileservice"
        exit 1
        ;;
esac