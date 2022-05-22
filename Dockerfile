FROM golang:1.18-alpine AS builder
WORKDIR /app
COPY go.mod ./
COPY go.sum ./
RUN go mod download
COPY *.go ./
RUN go build -o /hello-http

FROM golang:1.18-alpine
LABEL org.opencontainers.image.description "Simple HTTP server used for testing with Flux"
COPY --from=builder /hello-http /hello-http
EXPOSE 8080
CMD ["/hello-http"]
