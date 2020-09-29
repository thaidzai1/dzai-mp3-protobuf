#!/bin/bash
PROTOC_VERSION=3.13.0
PROTOC_FILENAME=protoc-$(echo $PROTOC_VERSION| grep -e "[^v]*" -o)
brew install jq
brew install unzip
PROTOC_FILENAME="$PROTOC_FILENAME-osx-$(uname -a|awk '{print $NF}').zip" 
PACKAGE_URL="https://github.com/protocolbuffers/protobuf/releases/download/v$PROTOC_VERSION/protoc-3.13.0-osx-x86_64.zip"
echo "Downloading $PACKAGE_URL... "
curl -L "$PACKAGE_URL" -O
rm -rf protoc-tmp 2>/dev/null
unzip -d protoc-tmp $PROTOC_FILENAME
sudo mv ./protoc-tmp/bin/* /usr/local/bin/
sudo rm -rf /usr/local/include/google/protobuf
sudo mkdir -p /usr/local/include/google
sudo mv ./protoc-tmp/include/google/protobuf /usr/local/include/google/
rm -rf protoc-tmp