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
rm -rf *.gem
sed -i "s/'${CURRENT_VERSION}'.freeze # rultor/'${tag}'.freeze # rultor/" ./lib/version.rb
gem build ruby-stream-api.gemspec
chmod 0600 /home/r/rubygems.yml
gem push *.gem --config-file /home/r/rubygems.yml
###

# set next dev version in version.rb
sed -i "s/'${tag}'.freeze # rultor/'${NEXT_VERSION}'.freeze # rultor/" ./lib/version.rb
bundle install

git commit -am "${NEXT_VERSION}"
git checkout master
git merge __rultor
git checkout __rultor

