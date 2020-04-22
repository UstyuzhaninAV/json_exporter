FROM golang:onbuild
EXPOSE 9116
# CMD ["go", "run"] # ["app"]

# Once 17.05 has arrived
#FROM alpine:latest
#RUN apk --no-cache add ca-certificates
#WORKDIR /root/
#COPY --from= as builder /go/app .
