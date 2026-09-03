# stage 1: compile. This stage carries the whole Go toolchain, ~250 MB of it.
FROM golang:1.22-alpine AS builder

WORKDIR /src

COPY go.mod ./
COPY main.go ./

# CGO_ENABLED=0 gives a static binary, so the final image needs no C library
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o /out/server main.go

# stage 2: scratch is an entirely empty base image
FROM scratch

# only the binary crosses over. Compiler, source and module cache stay behind.
COPY --from=builder /out/server /server

EXPOSE 8080

ENTRYPOINT ["/server"]
