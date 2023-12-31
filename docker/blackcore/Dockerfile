FROM golang:1.19-alpine3.16 AS go-builder

# Set up dependencies
ENV PACKAGES curl make git libusb-dev libc-dev bash gcc linux-headers eudev-dev python3

# Install ca-certificates
RUN set -eux; apk add --no-cache ca-certificates build-base;

# Install minimum necessary dependencies
RUN apk add --no-cache $PACKAGES

# See https://github.com/CosmWasm/wasmvm/releases
ADD https://github.com/CosmWasm/wasmvm/releases/download/v1.1.2/libwasmvm_muslc.aarch64.a /lib/libwasmvm_muslc.aarch64.a
ADD https://github.com/CosmWasm/wasmvm/releases/download/v1.1.2/libwasmvm_muslc.x86_64.a /lib/libwasmvm_muslc.x86_64.a
RUN sha256sum /lib/libwasmvm_muslc.aarch64.a | grep 77b41e65f6c3327d910a7f9284538570727e380ab49bc3c88c8d4053811d5209
RUN sha256sum /lib/libwasmvm_muslc.x86_64.a | grep e0a0955815a23c139d42781f1cc70beffa916aa74fe649e5c69ee7e95ff13b6b

# Copy the library you want to the final location that will be found by the linker flag `-lwasmvm_muslc`
RUN cp /lib/libwasmvm_muslc.$(uname -m).a /lib/libwasmvm_muslc.a

# Set working directory for the build
WORKDIR /usr/local/app

# Add source files
COPY . .

# Force it to use static lib (from above) not standard libgo_cosmwasm.so file
RUN LEDGER_ENABLED=false BUILD_TAGS="muslc linkstatic" make build
RUN echo "Ensuring binary is statically linked ..." \
  && (file /usr/local/app/build/blackCore | grep "statically linked")

FROM alpine:3.16

COPY --from=go-builder /usr/local/app/build/blackCore /usr/bin/blackCore

COPY contrib/local/ /opt/
RUN chmod +x /opt/*.sh

# Set up dependencies
ENV PACKAGES curl make bash jq
ENV CHAIN_BIN /usr/bin/blackCore

# Install minimum necessary dependencies
RUN apk add --no-cache $PACKAGES

WORKDIR /opt

# rest server, p2p, rpc, grpc
EXPOSE 1317 26656 26657 9090

# Run blackCore by default, omit entrypoint to ease using container with cli
CMD ["/usr/bin/blackCore", "version", "--long"]
