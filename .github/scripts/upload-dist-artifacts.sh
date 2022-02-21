#!/usr/bin/env bash
#
# Upload distribution artifacts to a release.
set -e

token=${1:-$GITHUB_TOKEN}

if [[ -z $token ]]; then
    >&2 echo "Error: GITHUB_TOKEN not provided as argument or env var."
    exit 1
fi
if [[ -z $GITHUB_EVENT_PATH ]]; then
    >&2 echo "Error: GITHUB_EVENT_PATH is not set."
    exit 1
fi

upload_url=$( jq -r '.release.upload_url' <"$GITHUB_EVENT_PATH" )

# get rid of the {?name,label} part of the URL
# https://uploads.github.com/.../assets{?name,label}   becomes
# https://uploads.github.com/.../assets
_brace='{'
upload_url=${upload_url%$_brace*}

if [[ -z $upload_url ]]; then
    >&2 echo "Error: Cannot determine upload URL from GITHUB_EVENT_PATH."
    exit 1
fi

for file in dist/* ; do
    echo "Uploading $file..."

    # URL-encode with jq, see https://stackoverflow.com/a/34407620
    name=$(jq -rn --arg x $(basename $file) '$x|@uri')
    label=$name

    if [[ $file == *.tar.gz ]]; then
        # https://superuser.com/a/960710
        content_type=application/gzip
    elif [[ $file == *.whl ]]; then
        # https://stackoverflow.com/a/58543864
        content_type=application/x-pywheel+zip
    else
        content_type=application/binary
    fi

    # https://docs.github.com/en/rest/reference/releases#upload-a-release-asset
    curl --fail -sS \
         --header "Accept: application/vnd.github.v3+json" \
         --header "Authorization: Bearer $token" \
         --header "Content-Type: $content_type" \
         --data-binary "@$file" \
         "$upload_url?name=$name&label=$label"

    echo -e "\nDone.\n"
done
