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

# ERRORS:
#rspec /vagrant/softcover/spec/app_spec.rb:29 # Softcover::App ordinary book GET chapter
#rspec /vagrant/softcover/spec/builders/epub_spec.rb:15 # Softcover::Builders::Epub should be valid
#rspec /vagrant/softcover/spec/builders/epub_spec.rb:155 # Softcover::Builders::Epub OEBPS HTML generation should create math PNGs
#rspec /vagrant/softcover/spec/builders/epub_spec.rb:191 # Softcover::Builders::Epub for a Markdown book should be valid
#rspec /vagrant/softcover/spec/builders/pdf_spec.rb:40 # Softcover::Builders::Pdf for a PolyTeX book #build! should prepend the fontsize verbatim declaration for source code

# Build new book template.
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

# ERRORS: build:pdf
#/home/vagrant/.rvm/gems/ruby-2.1.1/gems/polytexnic-0.9.2/lib/polytexnic/utils.rb:136:in `gsub!': incompatible character encodings: ISO-8859-1 and UTF-8 (Encoding::CompatibilityError)

echo "ALL TESTS PASSED!"
