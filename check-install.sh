#!/usr/bin/env bash

set -v
# TODO replace by euv once Softcover bugs are fixed:
#set -euv

tmpdir="/vagrant/tmp"

# Binary dependencies.
softcover check

mkdir -p "$tmpdir"

# Unit tests.
cd "$tmpdir"
if [ -d softcover ]; then
  cd softcover_book
  git pull -u origin master
else
  git clone https://github.com/softcover/softcover
  cd softcover
fi
bundle install
bundle exec rake spec

# Build new book template.
cd "$tmpdir"
softcover new example_book
cd example_book
softcover build

# Build softcover_book.
cd "$tmpdir"
if [ -d softcover_book ]; then
  cd softcover_book
  git pull -u origin master
else
  git clone https://github.com/softcover/softcover_book
  cd softcover_book
fi
softcover build

# TODO uncomment once Softcover bugs are fixed:
#echo "Test builds put in: /vagrant/tmp"
#echo "All tests passed."
