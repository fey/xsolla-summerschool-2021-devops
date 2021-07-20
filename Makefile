
install:
	npm ci

start:
	npx slidev presentation.md --open

build:
	rm -rf build
	npx slidev build presentation.md -o build

.PHONY: build
