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

# Function to authenticate and get access token for OneDrive
get_onedrive_token() {
    CLIENT_ID="your_client_id"
    CLIENT_SECRET="your_client_secret"
    TENANT_ID="your_tenant_id"
    SCOPE="https://graph.microsoft.com/.default"
    
    # Get the access token
    TOKEN_RESPONSE=$(curl -s -X POST "https://login.microsoftonline.com/$TENANT_ID/oauth2/v2.0/token" \
        -H "Content-Type: application/x-www-form-urlencoded" \
        -d "client_id=$CLIENT_ID&client_secret=$CLIENT_SECRET&scope=$SCOPE&grant_type=client_credentials")
    
    ACCESS_TOKEN=$(echo "$TOKEN_RESPONSE" | jq -r '.access_token')

    # Check if the token was retrieved successfully
    if [[ "$ACCESS_TOKEN" == "null" ]]; then
        echo "ERROR: Failed to retrieve access token."
        echo "Response: $TOKEN_RESPONSE"
        exit 1
    fi
}

# Function to upload to OneDrive
upload_to_onedrive() {
    get_onedrive_token

    # Upload the file to OneDrive
    UPLOAD_URL="https://graph.microsoft.com/v1.0/me/drive/root:/$FILE:/content"
    
    RESPONSE=$(curl -s -X PUT "$UPLOAD_URL" \
        -H "Authorization: Bearer $ACCESS_TOKEN" \
        -H "Content-Type: application/octet-stream" \
        --data-binary @"$FILE")

    # Check if the upload was successful
    if [[ $? -ne 0 ]]; then
        echo "ERROR: Failed to upload the file to OneDrive."
        echo "Please check your internet connection and try again."
        exit 1
    fi

    # Extract the download link from the response
    LINK=$(echo "$RESPONSE" | jq -r '.webUrl')

    # Check if the link was successfully extracted
    if [[ "$LINK" == "null" ]]; then
        echo "ERROR: Failed to retrieve the download link from OneDrive."
        echo "Response: $RESPONSE"
        exit 1
    fi

    # Display the download link
    echo "Download link from OneDrive: $LINK"
}

# Determine which service to use
case "$SERVICE" in
    gofile)
        upload_to_gofile
        ;;
    onedrive)
        upload_to_onedrive
        ;;
    *)
        echo "ERROR: Unknown service '$SERVICE'."
        echo "Available services: gofile, anotherfileservice"
        exit 1
        ;;
esac