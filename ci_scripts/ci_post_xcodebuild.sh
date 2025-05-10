#!/bin/sh

echo "🔧 asdas"

if [[ $CI_XCODEBUILD_ACTION = "archive" ]];
then
    echo "🔧 Archive action detected"

    if [[ $CI_WORKFLOW = "Default" ]];
    then
    ##CI_APP_STORE_SIGNED_APP_PATH vs CI_DEVELOPMENT_SIGNED_APP_PATH
        cd $CI_APP_STORE_SIGNED_APP_PATH
        echo ":open_file_folder: Changed to dev signed app path: $CI_APP_STORE_SIGNED_APP_PATH"
        appName=$(ls *.ipa | head -n 1)
        echo "Uploading to GCS..."
        curl -T "$appName" -H "Content-Type: application/octet-stream" "https://storage.googleapis.com/builds_webhook/7e7fa93b-9605-4eac-be2d-309cb20e76f6/Mojo.ipa"
        echo "Upload completed"
    fi
fi
