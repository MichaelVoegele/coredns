# FROM registry.redhat.io/rhel8/go-toolset:latest AS builder
FROM registry.access.redhat.com/ubi8:latest AS builder

# RUN dnf -y install go-toolset && go version

WORKDIR /go/src/github.com/coredns/coredns
COPY . .
RUN ls -al
RUN ls -al /go/src/github.com/coredns/coredns/

ENV GO_VERSION=1.17.9 \
    PATH=${PATH}:/usr/local/go/bin

# RUN set -x \
#     # && rm -rf /usr/local/go \
#     && curl -SL https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz -o go.tar.gz \
#     && tar -C /usr/local -xzf go.tar.gz \
#     # && export PATH=${PATH}:/usr/local/go/bin \
#     && go version

# RUN dnf -y install go-toolset && go version

# RUN pwd && ls -al
# RUN find / -type d -name coredns

# WORKDIR /go/src/github.com/coredns/coredns
# COPY . .
# RUN ls -al

# RUN GO111MODULE=on GOFLAGS=-mod=vendor go build -o coredns .
# RUN go get github.com/coredns/alternate
# RUN go install github.com/coredns/alternate@latest
# RUN go mod vendor
# RUN ls -al
# RUN go generate

# RUN GO111MODULE=on GOFLAGS=-mod=vendor go build -o coredns .
# RUN go build -mod=mod -o coredns .

# FROM registry.access.redhat.com/ubi8:latest
# COPY --from=builder /go/src/github.com/coredns/coredns/coredns /usr/bin/

# RUN dnf -y install bind-utils

# ENTRYPOINT ["/usr/bin/coredns"]

# LABEL io.k8s.display-name="CoreDNS" \
#       io.k8s.description="CoreDNS delivers the DNS and Discovery Service for a Kubernetes cluster." \
#       maintainer="dev@lists.openshift.redhat.com"
