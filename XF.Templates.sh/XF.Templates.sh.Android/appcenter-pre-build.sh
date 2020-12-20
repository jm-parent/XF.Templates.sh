#!/usr/bin/env bash

echo "##[warning][Pre-Build Action] - Lets do some Pre build transformations..."

# Declare local script variables
SCRIPT_ERROR=0

# Define the files to manipulate
CONSTANTS_FILE=${APPCENTER_SOURCE_DIRECTORY}/XF.Templates.sh/Constants.cs

echo "##[warning][Pre-Build Action] - Checking if all files and environment variables are available..."

if [ -z "${API_URL}" ]
then
    echo "##[error][Pre-Build Action] - API_URL variable needs to be defined in App Center!!!"
    let "SCRIPT_ERROR += 1"
    else
    echo "##[warning][Pre-Build Action] - API_URL variable - oK!"
fi

if [ -e "${CONSTANTS_FILE}" ]
then
    echo "##[warning][Pre-Build Action] - Constants.cs file found - oK!"
else
    echo "##[error][Pre-Build Action] - Constants.cs file not found!"
    let "SCRIPT_ERROR += 1"
fi

if [ ${SCRIPT_ERROR} -gt 0 ]
then
    echo "##[error][Pre-Build Action] - There are ${SCRIPT_ERROR} errors."
    echo "##[error][Pre-Build Action] - Fix them and try again..."
    exit 1 # this will kill the build
    # exit # this will exit this script, but continues building
    else
fi

echo "##[warning][Pre-Build Action] - There are ${SCRIPT_ERROR} errors."
echo "##[warning][Pre-Build Action] - Now everything is checked, lets change some data ..."


if [ -e "${CONSTANTS_FILE}" ]
then
    echo "##[command][Pre-Build Action] - Changing the ApiUrl to: ${API_URL} "
    sed -i '' "s/ApiUrl = \"[-a-zA-Z0-9_ ]*\"/ApiUrl = \"${API_URL}\"/" ${CONSTANTS_FILE}

    echo "##[section][Pre-Build Action] - Constants.cs File content:"
    cat ${CONSTANTS_FILE}
    echo "##[section][Pre-Build Action] - Constants.cs EOF"
fi