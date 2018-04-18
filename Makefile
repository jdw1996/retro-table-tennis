MAKEFLAGS += --warn-undefined-variables

SOURCE_DIR := src
SOURCE_MAIN_FILE := ${SOURCE_DIR}/main.dart

OUTPUT_DIR := build
OUTPUT_FILE := main.js

.PHONY: all

all: ${OUTPUT_FILE}

${OUTPUT_FILE}: ${SOURCE_MAIN_FILE}
	mkdir -p ${OUTPUT_DIR}
	dart2js -m $< -o $@
