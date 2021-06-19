presentation:
	npx @marp-team/marp-cli -w presentation.md

build:
	rm -rf build
	npx @marp-team/marp-cli presentation.md -o build/index.html
