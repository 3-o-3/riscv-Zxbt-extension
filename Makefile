
DOCS := \
	ternary-spec.adoc

DATE ?= $(shell date +%Y-%m-%d)
VERSION ?= v0.1.0
REVMARK ?= Draft

SRC_DIR := src
BUILD_DIR := build

DOCS_PDF := $(DOCS:%.adoc=%.pdf)
DOCS_HTML := $(DOCS:%.adoc=%.html)

OPT := --trace \
           -a compress \
           -a webfonts! \
           -a mathematical-format=svg \
           -a revnumber=${VERSION} \
           -a revremark=${REVMARK} \
           -a revdate=${DATE} \
		   -D build \
           --failure-level=ERROR \
	   --require=asciidoctor-bibtex \
            --require=asciidoctor-diagram \
			--require=asciidoctor-lists \
            --require=asciidoctor-mathematical

all: build-docs

build-docs: $(DOCS_PDF) $(DOCS_HTML)

vpath %.adoc $(SRC_DIR)

%.pdf: %.adoc
	asciidoctor-pdf $(OPT)  $< 

%.html: %.adoc
	asciidoctor $(OPT)  $< 

clean:
	rm -rf $(BUILD_DIR)/* $(BUILD_DIR)/.asciidoctor
