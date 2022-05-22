FROM golang:1.18-alpine AS builder
WORKDIR /app
COPY go.mod ./
COPY go.sum ./
RUN go mod download
COPY *.go ./
RUN go build -o /hello-http

FROM golang:1.18-alpine
COPY --from=builder /hello-http /hello-http
EXPOSE 8080
CMD ["/hello-http"]
