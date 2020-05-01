#!/bin/bash
# Release script to be run by Rultor.

set -e
set -o pipefail

CURRENT_VERSION=$(grep -o '[0-9]*\.[0-9]*\.[0-9]*-SNAPSHOT' -m 1 ./lib/version.rb)

NUMBERS=($(echo $tag | grep -o -E '[0-9]+'))

echo "CURRENT VERSION IS"
echo $CURRENT_VERSION

NEXT_VERSION=${NUMBERS[0]}'.'${NUMBERS[1]}'.'$((${NUMBERS[2]}+1))'-SNAPSHOT'

echo "RELEASE VERSION IS"
echo $tag

echo "NEXT VERSION IS"
echo $NEXT_VERSION

### Actual Script Here

#set the release version in version.rb
###

git commit -am "${NEXT_VERSION}"
git checkout master
git merge __rultor
git checkout __rultor

