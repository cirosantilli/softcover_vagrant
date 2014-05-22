#!/usr/bin/env bash

set -v
# TODO replace by euv once Softcover bugs are fixed:
#set -euv

projects_dir="/vagrant/projects"

# Binary dependencies.
softcover check

# Unit tests.
cd /vagrant
if [ ! -d softcover ]; then
  git clone https://github.com/softcover/softcover
fi
cd softcover_book
bundle install
bundle exec rake spec

mkdir -p "$projects_dir"

# Build new book template.
cd "$projects_dir"
softcover new example_book
cd example_book
softcover build

# Build softcover_book.
cd "$projects_dir"
if [ ! -d softcover_book ]; then
  git clone https://github.com/softcover/softcover_book
fi
softcover build

# TODO uncomment once Softcover bugs are fixed:
#echo "All tests passed."
