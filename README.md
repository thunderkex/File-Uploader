# Usage:
```bash
chmod +x main.sh
./main.sh <file_path> [service (gofile / onedrive)]
```
# OneDrive Access Token Retrieval Guide

This guide will walk you through the process of obtaining an access token for OneDrive using user authentication via the OAuth 2.0 authorization code flow. Follow the steps below to successfully integrate OneDrive access into your application.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Steps to Obtain an Access Token](#steps-to-obtain-an-access-token)
  - [1. Register Your Application](#1-register-your-application)
  - [2. Use the Access Token](#4-use-the-access-token)

## Prerequisites
- An Azure account. If you don't have one, you can create it [here](https://azure.microsoft.com/free/).
- Basic understanding of OAuth 2.0 and REST APIs.

## Steps to Obtain an Access Token

### 1. Register Your Application
To begin, you need to register your application in the Azure portal. This will provide you with the necessary credentials: `client_id` and `client_secret`.

- **Azure Portal**: [Azure Portal](https://portal.azure.com)
- **Steps**:
  1. Navigate to the Azure Active Directory section.
  2. Select "App registrations" and click on "New registration".
  3. Fill in the required details and set the redirect URI.

### 2. Use the Access Token
With the access token obtained, Copy to CLIENT_ID="your_client_id"
    CLIENT_SECRET="your_client_secret"
    TENANT_ID="your_tenant_id"