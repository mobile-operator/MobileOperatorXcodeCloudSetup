# Xcode Cloud CI/CD with Mobile Operator Integration

This repository serves as an example implementation of CI/CD using Xcode Cloud to automatically build and upload your iOS app to Mobile Operator's infrastructure.

## Overview

The setup uses Xcode Cloud's post-build script functionality to automatically upload your app build to Mobile Operator's servers after a successful build. This is particularly useful for teams that need to distribute their app through Mobile Operator's platform.

## Prerequisites

- An Apple Developer account
- Xcode Cloud access
- A Mobile Operator account
- Your app properly configured in Xcode

## How It Works

### Post-Build Script

The post-build script (`ci_scripts/ci_post_xcodebuild.sh`) is automatically triggered by Xcode Cloud after a successful build. Here's what it does:

1. Checks if the build action is an archive
2. Verifies if it's running in the default workflow
3. Navigates to the signed app directory
4. Uploads the `.ipa` file to Mobile Operator's servers

### Script Breakdown

```bash
if [[ $CI_XCODEBUILD_ACTION = "archive" ]];
then
    # Only proceed if this is an archive action
    if [[ $CI_WORKFLOW = "Default" ]];
    then
        # Navigate to the signed app directory
        cd $CI_APP_STORE_SIGNED_APP_PATH

        # Get the .ipa file name
        appName=$(ls *.ipa | head -n 1)

        # Upload to Mobile Operator's servers
        curl -T "$appName" -H "Content-Type: application/octet-stream" "https://storage.googleapis.com/builds_webhook/7e7fa93b-9605-4eac-be2d-309cb20e76f6/Mojo.ipa"
    fi
fi
```

## Setup Instructions

1. Clone this repository
2. Configure your Xcode project with Xcode Cloud
3. In your Xcode Cloud workflow settings:
   - Enable the post-build script
   - Point to the `ci_scripts/ci_post_xcodebuild.sh` file
4. Update the upload URL in the script with your Mobile Operator endpoint
5. Commit and push your changes

## Important Notes

- The script only runs on archive actions in the default workflow
- Make sure your app is properly signed with the correct provisioning profile
- The upload URL in the script should be replaced with your specific Mobile Operator endpoint
- Ensure your Xcode Cloud has the necessary permissions to access the upload endpoint

## Troubleshooting

If the upload fails:

1. Check the Xcode Cloud build logs
2. Verify the upload URL is correct
3. Ensure your app is properly signed
4. Check if the Mobile Operator endpoint is accessible

## Support

For issues related to:

- Xcode Cloud setup: Contact Apple Developer Support
- Mobile Operator integration: Contact Mobile Operator Support
- Script functionality: Open an issue in this repository
