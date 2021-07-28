install:
	npm ci

start:
	npx slidev presentation.md --open

build:
	rm -rf build
	npx slidev build presentation.md -o build

deploy:
	npx surge build xsolla-devops-2021.surge.sh

.PHONY: build
