#!/bin/bash
#
# retrieves the current version from the package.json

jq -rM '.version' package.json