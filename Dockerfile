FROM golang:1.16.7-alpine3.14
WORKDIR /app
COPY src .
RUN CGO_ENABLED=0 GO111MODULE=on GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o golang-test .

FROM scratch
COPY --from=0 /app/golang-test /app/
ENTRYPOINT ["/app/golang-test"]
EXPOSE 8000
USER 65534:65534
