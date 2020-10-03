# dzai-mp3-protobuf

`protoc -I./api/ -I./pkg/pb -I/usr/local/include -I$GOPATH/src -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis --go_out=plugins=grpc:./pkg/pb api/**/*.proto`

`protoc --proto_path=. --go_out=plugins=grpc:$GOPATH/src/. ./api/**/*.proto`

`protoc --proto_path=. -I/usr/local/include -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis --grpc-gateway_out=logtostderr=true:$GOPATH/src/. ./api/**/*.proto`
