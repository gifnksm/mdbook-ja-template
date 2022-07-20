MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables

SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
.SECONDEXPANSION:

export UID = $(shell id -u)
export GID = $(shell id -g)

DOCKER_COMPOSE ?= docker compose
RUN = $(DOCKER_COMPOSE) run --rm

.PHONY: default
default: build


## Build a book from source files (default target)
.PHONY: build
build:
	$(RUN) mdbook build

## Delete a built book
.PHONY: clean
clean:
	$(RUN) mdbook clean

## Watch book source files and rebuild a book on changes
.PHONY: watch
watch:
	$(RUN) mdbook watch || true

## Serve a book at http://localhost:3000/, and rebuild it on changes
.PHONY: serve
serve:
	$(DOCKER_COMPOSE) up mdbook || true


## Pull the latest version of Docker images
.PHONY: pull
pull:
	$(DOCKER_COMPOSE) pull


## Setup host environment for the book
.PHONY: setup-host
setup-host: .env package.json package-lock.json npm-install

.env: FORCE
	echo "UID=$(UID)" > $@
	echo "GID=$(GID)" >> $@

package.json package-lock.json: FORCE
	$(RUN) sh -c "cp /npm/$@ $@"

.PHONY: npm-install
npm-install:
	npm install


## Run linters/tests on book source files
.PHONY: check
check: check-markdown check-textlint check-mdbook

## Run markdownlint on book source files
.PHONY: check-markdown
check-markdown:
	$(RUN) markdownlint .

## Run textlint on book source files
.PHONY: check-textlint
check-textlint:
	$(RUN) textlint .

## Run tests that Rust codes in a book compile without errors
.PHONY: check-mdbook
check-mdbook:
	$(RUN) mdbook test


## Fix basic errors in book source files
.PHONY: fix
fix: fix-markdown fix-textlint

## Fix basic errors in book source files with markdownlint
.PHONY: fix-markdown
fix-markdown:
	$(RUN) markdownlint --fix .

## Fix basic errors in book source files with textlint
.PHONY: fix-textlint
fix-textlint:
	$(RUN) textlint --fix .


## Print this message
help:
	@printf "Available targets:\n\n"
	@awk '/^[a-zA-Z\-_0-9%:\\]+/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = $$1; \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			gsub("\\\\", "", helpCommand); \
			gsub(":+$$", "", helpCommand); \
			printf "  \x1b[32;01m%-16s\x1b[0m %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ \
		if ($$0 !~ /^.PHONY/) { \
			lastLine = $$0 \
		} \
	} \
	' $(MAKEFILE_LIST) | sort -u
	@printf "\n"

.PHONY: FORCE
FORCE:
