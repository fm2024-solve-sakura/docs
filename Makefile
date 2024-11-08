# generate openapi docs
redocly:
	@if ! command -v redocly > /dev/null 2>&1; then \
		npm install -g @redocly/cli; \
	fi
	redocly bundle openapi/all.yaml -o openapi/all.gen.yaml
	redocly build-docs openapi/all.gen.yaml -o openapi/index.html

oapi-codegen:
	@if ! command -v $$(go env GOPATH)/bin/oapi-codegen > /dev/null 2>&1; then \
		go install github.com/oapi-codegen/oapi-codegen/v2/cmd/oapi-codegen@latest; \
	fi
	$$(go env GOPATH)/bin/oapi-codegen -generate types -package openapi -o ../backend/pkg/openapi/types.gen.go openapi/all.gen.yaml
	$$(go env GOPATH)/bin/oapi-codegen -generate server -package openapi -o ../backend/pkg/openapi/server.gen.go openapi/all.gen.yaml

openapi: redocly codegen
