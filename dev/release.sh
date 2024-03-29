#!/bin/bash
#
# Trigger new release creation on Github.
#

set -e

if (( $# > 1 )); then
	echo "usage: `basename $0` [version]"
	exit 1
fi

# Get the latest version (needs curl + jq).
if (( $# == 0 )); then
	curl -s https://api.github.com/repos/devnull-cz/unix-linux-prog-in-c/releases/latest | \
	    jq .tag_name
	exit 0
fi

VERSION=$1

if ! echo "$VERSION" | grep '^v[0-9]\+$' >/dev/null; then
	echo "version needs to be 'v<number>'"
	exit 1
fi

ver=$( git tag -l "$VERSION" )
if (( $? != 0 )); then
	echo "Cannot determine tag"
	exit 1
fi
if [[ $ver == $VERSION ]]; then
	echo "Tag $VERSION already exists"
	exit 1
fi

echo "Pulling"
git pull --ff-only
git tag "$VERSION"
echo "Pushing"
git push origin tag "$VERSION"
