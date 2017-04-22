#!/bin/bash

#./apothecary/install.sh

# This script assumes it is in the openFrameworks/addons/THE_ADDON/scripts dir.
OF_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../../../" && pwd )"

# This is the default location for apothecary.
APOTHECARY_DIR=$OF_ROOT/scripts/apothecary

# Clean any prior builds.
$APOTHECARY_DIR/apothecary/./apothecary -v clean ofxFAISS

# Build using apothcary
$APOTHECARY_DIR/apothecary/./apothecary -v -j16 -d ../libs update ofxFAISS

