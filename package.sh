#!/usr/bin/env bash
output="precise64_softcover.box"
vagrant package --base softcover_vagrant_dev --output "$output"
echo "Output at: $output"
