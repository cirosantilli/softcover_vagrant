#!/usr/bin/env bash

set -euv

# This should be run from inside the guest.
# All commands must exit with status 0.
# You must manually check outputs where applicable to see if they are OK.

# Binary dependencies.
softcover check

# Unit tests. FAIL
cd /vagrant/softcover
bundle install
bundle exec rake spec

# Build new book template. FAIL
cd /tmp
softcover new example_book
cd example_book
softcover build
cd ..
rm -rf example_book

# Build softcover_book. FAIL
cd /tmp
git clone https://github.com/softcover/softcover_book
cd softcover_book
softcover build
cd ..
rm -rf softcover_book

echo "ALL TESTS PASSED!"
