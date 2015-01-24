GO := `which go`
GOFMT := `which gofmt`
GOVET := ./scripts/vet

all: cli server

cli: 
	@/bin/bash ./scripts/build cli talkie

server:
	@/bin/bash ./scripts/build server

test: cli server
	@/bin/bash ./scripts/test cli/app
	@/bin/bash ./scripts/test server

check:
	@./.hooks/pre-commit

vet:
	@git ls-files | grep '.go$$' | while read i; do $(GO) vet $$i 2>&1; done | grep -v exit\ status | grep -v pb.go | grep -v Error\ call

format:
	@git ls-files | grep '.go$$' | xargs $(GOFMT) -w -s

deps:
	@/bin/bash ./scripts/deps

.PHONY = all cli server test check vet format deps
