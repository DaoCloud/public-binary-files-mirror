# note: call scripts from /scripts
BINDIR      := $(CURDIR)/bin
BINNAME     ?= public-binary-file-mirror

# go option
PKG        := ./...
TESTS      := .
TESTFLAGS  :=
LDFLAGS    := -w -s
GOFLAGS    :=


# VERSION is the version of the binary.

GIT_TAG ?= $(shell git describe --tags --abbrev=0 --exact-match 2>/dev/null)
GIT_TAG_SHA ?= $(shell git describe --tags --dirty 2>/dev/null)

# TAG is the tag of the container image, default to binary version.
TAG?=$(GIT_TAG_SHA)

# Clear the "unreleased" string in BuildMetadata
ifneq ($(GIT_TAG),)
	TAG = ${GIT_TAG}
endif

# REGISTRY is the container registry to push into.
REGISTRY?=ghcr.io/daocloud

# IMAGE is the image name of the node problem detector container image.
IMAGE:=$(REGISTRY)/public-binary-files-mirror:$(TAG)

# Rebuild the binary if any of these files change
SRC := $(shell find . -type f -name '*.go' -print) go.mod go.sum

.PHONY: all
all: build


# ------------------------------------------------------------------------------
#  build

.PHONY: build
build: $(BINDIR)/$(BINNAME)

$(BINDIR)/$(BINNAME): $(SRC)
	GO111MODULE=on go build $(GOFLAGS) -trimpath -tags '$(TAG)' -ldflags '$(LDFLAGS)' -o '$(BINDIR)'/$(BINNAME) .

# ------------------------------------------------------------------------------
#  test

.PHONY: test
test: test-unit
.PHONY: test-unit
test-unit:
	@echo
	@echo "==> Running unit tests <=="
	GO111MODULE=on go test $(GOFLAGS) -run $(TESTS) $(PKG) $(TESTFLAGS)

# ------------------------------------------------------------------------------
#  clean

.PHONY: clean
clean:
	rm -rf bin

# ------------------------------------------------------------------------------
#  build-container

build-container: 
	@echo "Build Image: $(IMAGE)"
	@docker build -t "$(IMAGE)" --file ./Dockerfile .
# ------------------------------------------------------------------------------
#  release-container

release-container: build-container
	@docker push $(IMAGE)