#!/bin/bash

# Die if any command fails
set -e

# Check params
SCRIPT="${0}"
if [ -z "${1}" ]; then
  echo "usage: ./${SCRIPT} [<language>]";
  exit 1
fi
LANGUAGE="${1}"

# Move to the top level directory
if [ ! -d "${APP_DIR}" ]; then
  APP_DIR=`dirname "$SCRIPT"`/..
  APP_DIR=`cd "${APP_DIR}"; pwd`
fi

# Setup the gapic-generator executable
cd $APP_DIR && ./gradlew clean
cd $APP_DIR && ./gradlew fatjar
EXECUTABLE="${APP_DIR}/build/libs/gapic-generator-latest-fatjar.jar"

# Ensure output directory exists
TEMP_DIR="${APP_DIR}/tmp/showcase/${LANGUAGE}"
if [ ! -d "${TEMP_DIR}" ]; then mkdir -p $TEMP_DIR; fi

# Invoke gapic-generator
TEST_SRC="${APP_DIR}/src/test/java/com/google/api/codegen/testsrc/"
java -cp $EXECUTABLE com.google.api.codegen.GeneratorMain \
LEGACY_GAPIC_AND_PACKAGE \
--descriptor_set=$TEST_SRC/showcase.desc \
--package_yaml2=$TEST_SRC/showcase_pkg2.yaml \
--output=$TEMP_DIR \
--language=$LANGUAGE \
--service_yaml=$TEST_SRC/showcase.yaml \
--gapic_yaml=$TEST_SRC/showcase_gapic.yaml

# Copy generated code to output dir
OUTPUT_DIR="${APP_DIR}/showcase/${LANGUAGE}"
if [ ! -d "${OUTPUT_DIR}" ]; then mkdir -p $OUTPUT_DIR; fi
cp -r $TEMP_DIR/* $OUTPUT_DIR
