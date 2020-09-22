#!/bin/bash
DIR=$GOPATH/src/github.com/thaidzai285/dzai-mp3-protobuf
IMPORT="-I$DIR/api \
    -I$DIR \
    -I/src/github.com/grpc-ecosystem/grpc-gateway"

if [ ! -z "$1" ] ; then
    FILTER="/$1"
    echo "Reading from directory: $1"
    if [ ! -d $DIR/api/$1 ]; then
        echo "Invalid directory: $DIR/api/$1"
        exit 1
    fi
fi

function clean() {
    FILES=$1
    if ls $FILES 1>/dev/null 2>/dev/null; then
        rm $FILES
    fi
}

for PKG in $(find $DIR/pkg/pb$FILTER -type d); do
    clean $PKG/*.pb.go
    clean $PKG/*.pb.gw.go
    clean $PKG/*.pb.gen.go
    clean $PKG/*.swagger.json
done

# stop as soon as encounting an error
set -e

# protoc $IMPORT --go_out=plugins=grpc:$GOPATH/src/. $DIR/protobuf/common/*.proto
# echo "Generated from: $DIR/protobuf/common"

for PKG in $(find $DIR/api$FILTER -type d | grep -v common | grep -v google); do
    PKGNAME=$(basename $PKG)
    PROTO=$PKG/*.proto
    if ls $PROTO 1>/dev/null 2>/dev/null; then
        echo "Generated from: $PKG"
        protoc $IMPORT --go_out=plugins=grpc:$GOPATH/src/. $PROTO
    fi
done

printf "\n✔ Done\n"
