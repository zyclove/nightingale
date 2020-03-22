FROM golang:alpine AS builder
RUN apk add --no-cache git
WORKDIR /app

# comment this if using vendor
# ENV GOPROXY=https://mod.gokit.info
# COPY go.mod go.sum ./
# RUN go mod download

COPY . .
ENV GOPROXY=https://mod.gokit.info
RUN go build -o ./bin/monapi src/modules/monapi/monapi.go

FROM alpine:3.10
LABEL maintainer="llitfkitfk@gmail.com"
RUN apk add --no-cache tzdata ca-certificates

WORKDIR /app

COPY --from=builder /app/etc /app/etc
COPY --from=builder /app/bin /usr/local/bin

# ENTRYPOINT []
# CMD []