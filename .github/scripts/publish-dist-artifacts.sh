#!/usr/bin/env bash
#
# Publish distribution artifacts to PyPI or Test PyPI, if applicable.
# The publishing target is determined from the version number.
# Credentials are expected to be configured in the ~/.pypirc file.
set -e

version=${1:-$GITHUB_REF_NAME}

# remove leading "v", if present
version=${version#v}

if [[ -z $version ]]; then
    >&2 echo "Error: No version provided."
    exit 1
fi

case $version in
    *dev*)
        echo "No publishing. (development release)"
        exit 0
        ;;

    *[ab]*)
        echo "Publishing to Test PyPI. (alpha or beta release)"
        repository=testpypi
        ;;

    *)
        echo "Publishing to PyPI proper."
        repository=pypi
        ;;
esac


# https://packaging.python.org/en/latest/tutorials/packaging-projects/#uploading-the-distribution-archives

echo -e "\nInstalling latest twine..."
python3 -m pip install --upgrade twine

echo -e "\nUploading to $repository..."
python3 -m twine upload --non-interactive --disable-progress-bar \
        --repository "$repository" --skip-existing dist/*$version*

echo -e "\nDone."
