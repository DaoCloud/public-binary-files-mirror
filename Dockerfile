################################################################################
## GO BUILDER
################################################################################
FROM golang:1.18.5 as builder
# FROM docker.m.daocloud.io/golang:1.18 as builder

ENV CGO_ENABLED 0
ENV BUILD_DIR /build

RUN mkdir -p ${BUILD_DIR}
WORKDIR ${BUILD_DIR}

RUN go env -w GO111MODULE=on
# RUN go env -w GOPROXY=https://goproxy.cn,direct

COPY go.* ./
RUN go mod download
COPY . .

# RUN make test
RUN make build

# ################################################################################
# ## DEPLOYMENT CONTAINER
# ################################################################################
# FROM alpine

EXPOSE 8080
# COPY --from=builder /build/bin/public-binary-file-mirror /

ENTRYPOINT ["/build/bin/public-binary-file-mirror"]
CMD ["serve"]
