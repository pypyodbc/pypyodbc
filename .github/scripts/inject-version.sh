#!/usr/bin/env bash
#
# Put actual version number into the sources, in place of "0.0.0a0".
set -e

version=${1:-$GITHUB_REF_NAME}

# remove leading "v", if present
version=${version#v}

if [[ -z $version ]]; then
    >&2 echo "Error: No version provided."
    exit 1
fi

# sanity check - this doesn't cover everything in PEP 440
# https://www.python.org/dev/peps/pep-0440/#appendix-b-parsing-version-strings-with-regular-expressions
if [[ ! $version =~ ^[-.0-9abrcdevpost]+$ ]]; then
    >&2 echo "Error: Invalid character in version '$version'."
    exit 1
fi

echo "Setting version to '$version'."
sed -i -e "/version/s/0\.0\.0a0/$version/" setup.py pypyodbc.py
