# creating golang base image as builder for multistage build
FROM golang:1.16.3-alpine AS builder
# creating build directory for project
RUN mkdir /build
# adding project files to build directory
ADD go.mod go.sum main.go /build/
# poing build directory as work directory
WORKDIR /build
# generating project build 
RUN go build

# running project on alpine os as baseimage
FROM alpine
# adduser command -D::: Default -S:::Shell -h:::help --> adding user dhruv
RUN adduser -S -D -H -h  /app dhruv
# setting dhruv as user
USER dhruv
# taking build from builder image(copying gowebapp build file from uild directory to app directory)
COPY --from=builder /build/gowebapp /app/
# copying view files
COPY views/ /app/views
# poing app directory as work directory
WORKDIR /app
# executing project build
CMD ["./gowebapp"]