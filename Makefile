# generate openapi docs
redocly:
	@if ! command -v redocly > /dev/null 2>&1; then \
		npm install -g @redocly/cli; \
	fi
	redocly bundle openapi/all.yaml -o openapi/all.gen.yaml
	redocly build-docs openapi/all.gen.yaml -o openapi/index.html
