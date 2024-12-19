# Usage Instructions:
To execute the script, follow these commands in your terminal:
```bash
chmod +x main.sh
./main.sh <file_path> [service (gofile / onedrive / sourceforge)]
```

# OneDrive Access Token Retrieval Guide

This guide will walk you through the process of obtaining an access token for OneDrive using user authentication via the OAuth 2.0 authorization code flow. Follow the steps below to successfully integrate OneDrive access into your application.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Steps to Obtain an Access Token](#steps-to-obtain-an-access-token)
  - [1. Register Your Application](#1-register-your-application)
  - [2. Use the Access Token](#2-use-the-access-token)

## Prerequisites
Before you begin, ensure you have the following:
- An Azure account. If you don't have one, you can create it [here](https://azure.microsoft.com/free/).
- Basic understanding of OAuth 2.0 and REST APIs.

## Steps to Obtain an Access Token

### 1. Register Your Application
To begin, you need to register your application in the Azure portal. This will provide you with the necessary credentials: `client_id` and `client_secret`.

- **Azure Portal**: [Access the Azure Portal](https://portal.azure.com)
- **Steps**:
  1. Navigate to the Azure Active Directory section.
  2. Select "App registrations" and click on "New registration".
  3. Fill in the required details and set the redirect URI.

### 2. Use the Access Token
Once you have obtained the access token, you can use it in your application. Make sure to set the following environment variables:
```bash
CLIENT_ID="your_client_id"
CLIENT_SECRET="your_client_secret"
TENANT_ID="your_tenant_id"
```

# SourceForge API Key Guide

This guide will walk you through the process of obtaining an API key for SourceForge to upload files.

## Table of Contents
- [Prerequisites](#prerequisites-1)
- [Steps to Obtain an API Key](#steps-to-obtain-an-api-key)

## Prerequisites
Before you begin, ensure you have the following:
- A SourceForge account. If you don't have one, you can create it [here](https://sourceforge.net/user/registration).
- Basic understanding of REST APIs.

## Steps to Obtain an API Key

1. Log in to your SourceForge account.
2. Navigate to your account settings.
3. Find the API key section and generate a new API key.
4. Use the API key in your application by setting the following environment variable:
```bash
API_KEY="your_sourceforge_api_key"
PROJECT_NAME="your_project_name"
DEST_PATH="/path/on/sourceforge"
```