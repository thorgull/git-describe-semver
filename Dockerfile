FROM golang:1.14-alpine AS builder

WORKDIR /build
COPY ./ /build/
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o git-describe-semver ./cmd/git-describe-semver

FROM alpine
COPY --from=builder /build/git-describe-semver /bin/git-describe-semver
WORKDIR /workdir
ENTRYPOINT ["/bin/git-describe-semver"]
