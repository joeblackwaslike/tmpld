#!/usr/bin/env bash

REMOTE=${1:-origin}

CURRENT_TAG=$(git tag | sort -n | tail -1 | sed 's/^v//')

CURRENT_MAJOR=$(echo $CURRENT_TAG | cut -d'.' -f1)
CURRENT_MINOR=$(echo $CURRENT_TAG | cut -d'.' -f2)

NEXT_MINOR=$(expr $CURRENT_MINOR + 1)
NEXT_TAG="${CURRENT_MAJOR}.${CURRENT_MINOR}"

sed -i "/^version/s/$CURRENT_TAG/$NEXT_TAG/g" templates/vars.yaml
inv templates
git add .
git commit -m "Tag for release: $NEXT_TAG ..."

echo "Incrementing version $CURRENT_TAG > $NEXT_TAG ..."
git tag v$NEXT_TAG

echo "Pushing to github remote: $REMOTE ..."
# git push $REMOTE master --tags
