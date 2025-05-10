# Xcode Cloud CI/CD with Mobile Operator Integration

This repository serves as an example implementation of CI/CD using Xcode Cloud to automatically build and upload your iOS app to your Mobile Operator's account.

The setup uses Xcode Cloud's post-build script functionality to automatically upload your app build to Mobile Operator's servers after a successful build. This is particularly useful for teams that need to distribute their app through Mobile Operator's platform.

## API Key Setup

To use this integration, you'll need to obtain an API key from Mobile Operator:

1. Visit [mobileoperator.org](https://mobileoperator.org)
2. Log in or create an account
3. Navigate to your company
4. Grab your company api key.

Keep your API key secure and never commit it directly to your repository. Consider using environment variables or a secure secret management system.

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

1. Clone this repository
2. Configure your Xcode project with Xcode Cloud
3. In your Xcode Cloud workflow settings:
   - Enable the post-build script
   - Point to the `ci_scripts/ci_post_xcodebuild.sh` file
4. Update the upload URL in the script with your Mobile Operator endpoint
5. Commit and push your changes
