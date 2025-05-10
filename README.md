# Xcode Cloud CI/CD with Mobile Operator Integration

This repository demonstrates how to implement CI/CD using Xcode Cloud to automatically build and upload your iOS app to your Mobile Operator account.

## Overview

The integration leverages Xcode Cloud's post-build script functionality to automatically upload your app build to Mobile Operator's servers after a successful build. This solution is ideal for teams requiring automated distribution through the Mobile Operator platform.

## API Key Setup

To enable this integration, you'll need to obtain your company's API key from Mobile Operator:

1. Visit [mobileoperator.org](https://mobileoperator.org)
2. Log in or create an account
3. Navigate to your company settings
4. Retrieve your company API key

## How It Works

### Post-Build Script

The post-build script (`ci_scripts/ci_post_xcodebuild.sh`) is automatically triggered by Xcode Cloud after a successful build. Here's what it does:

1. Checks if the build action is an archive
2. Verifies if it's running in the specified workflow
3. Navigates to the signed app directory
4. Uploads the `.ipa` file to Mobile Operator's servers

### Script Breakdown

```bash
if [[ $CI_XCODEBUILD_ACTION = "archive" ]];
then
    # Only proceed if this is an archive action
    if [[ $CI_WORKFLOW = "Default" ]];
    # We recommend activating this for the builds you want to test. Releasing workflows.
    then
        # Navigate to the signed app directory
        cd $CI_APP_STORE_SIGNED_APP_PATH

        # Get the .ipa file name
        appName=$(ls *.ipa | head -n 1)

        # Upload to Mobile Operator's servers
        curl -T "$appName" -H "Content-Type: application/octet-stream" "https://storage.googleapis.com/builds_webhook/your_api_key/YourAppName.ipa"
    fi
fi
```

## Setup Instructions

1. Copy the `ci_post_xcodebuild.sh` script into your app's repository
2. Replace the API key placeholder with your company's API key
3. Update the workflow name from "Default" to match your release workflow name
