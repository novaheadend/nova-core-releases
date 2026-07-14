# syntax=docker/dockerfile:1
# Nova Core — official container image.
# Packages the pre-built static binary from the public release
# (Nova Core is closed-source; no source ships in this image).

FROM alpine:3.20 AS fetch
ARG VERSION
ARG TARGETARCH
ARG TARGETVARIANT
RUN set -eu; \
    apk add --no-cache curl tar; \
    case "${TARGETARCH}${TARGETVARIANT}" in \
      amd64) A=amd64 ;; \
      arm64) A=arm64 ;; \
      armv7) A=armv7 ;; \
      386)   A=i386  ;; \
      *) echo "unsupported platform ${TARGETARCH}${TARGETVARIANT}"; exit 1 ;; \
    esac; \
    base="https://github.com/novaheadend/nova-core-releases/releases/download/${VERSION}"; \
    f="nova-core-linux-${A}.tar.gz"; \
    curl -fsSL "${base}/${f}" -o "/tmp/${f}"; \
    curl -fsSL "${base}/${f}.sha256" -o "/tmp/${f}.sha256"; \
    cd /tmp && sha256sum -c "${f}.sha256" && tar -xzf "${f}"; \
    install -m 0755 /tmp/nova-core /usr/local/bin/nova-core

FROM alpine:3.20
RUN apk add --no-cache ca-certificates tzdata
COPY --from=fetch /usr/local/bin/nova-core /usr/local/bin/nova-core
# Admin UI on :80, stream egress on :8000. For DVB you must pass the tuner
# devices in (--device /dev/dvb/...) and usually run with --network host so
# UDP multicast and clients work cleanly.
EXPOSE 80 8000
VOLUME ["/config", "/opt/nova"]
ENTRYPOINT ["/usr/local/bin/nova-core"]
CMD ["-config", "/config/nova.json"]
