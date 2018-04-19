MAKEFLAGS += --warn-undefined-variables

SOURCE_DIR := src
SOURCE_MAIN_FILE := ${SOURCE_DIR}/main.dart
SOURCE_FILES := $(wildcard ${SOURCE_DIR}/*.dart)

OUTPUT_DIR := build
OUTPUT_FILE := ${OUTPUT_DIR}/main.js

.PHONY: all

all: ${OUTPUT_FILE}

${OUTPUT_FILE}: ${SOURCE_MAIN_FILE} ${SOURCE_FILES}
	mkdir -p ${OUTPUT_DIR}
	dart2js -m $< -o $@
