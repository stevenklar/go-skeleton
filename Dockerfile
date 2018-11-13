# Base build image
FROM golang:1.11-alpine

# Install some general depencencies
RUN apk add bash ca-certificates git gcc g++ libc-dev

WORKDIR /src

# Force go compiler to use go mod
ENV GO111MODULE=on CGO_ENABLED=1 GOOS=linux GOARCH=amd64 

# Download depencencies
COPY go.mod go.sum ./
RUN go mod download

# Copy in the source code
COPY . .

# And compile the project
RUN go build -a -tags netgo -ldflags '-w -extldflags "-static"' .

# App image
FROM scratch

# Copy in build binary
COPY --from=0 /src/app /app

# Run th ebinary
ENTRYPOINT ["/app"]

