FROM registry.access.redhat.com/ubi8:latest AS builder

ENV GO_VERSION=1.17.9 \
    PATH=${PATH}:/usr/local/go/bin

RUN set -x \
    # && rm -rf /usr/local/go \ -> if there was a previous version of go
    && curl -SL https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz -o /tmp/go.tar.gz \
    && tar -C /usr/local -xzf /tmp/go.tar.gz \
    && go version

WORKDIR /go/src/github.com/coredns/coredns
COPY . .
RUN ls -al

# RUN GO111MODULE=on GOFLAGS=-mod=vendor go build -o coredns .
RUN go get github.com/coredns/alternate
# RUN go install github.com/coredns/alternate@latest
# RUN go mod vendor
# RUN ls -al
# RUN go generate

# RUN GO111MODULE=on GOFLAGS=-mod=vendor go build -o coredns .
RUN go build -mod=mod -o coredns .

FROM registry.access.redhat.com/ubi8:latest
COPY --from=builder /go/src/github.com/coredns/coredns/coredns /usr/bin/

RUN dnf -y install bind-utils

ENTRYPOINT ["/usr/bin/coredns"]

LABEL io.k8s.display-name="CoreDNS" \
      io.k8s.description="CoreDNS delivers the DNS and Discovery Service for a Kubernetes cluster." \
      maintainer="OpenPaaS"
