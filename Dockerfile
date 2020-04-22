FROM golang:latest
ENV GO111MODULE=on
WORKDIR /go/src/app
COPY . .
RUN go mod init
RUN go get -d -v ./...
RUN go install -v ./...

CMD ["app"]
EXPOSE 9116
