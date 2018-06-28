#!/bin/bash

# Die if any command fails
set -e

# Move to the top level directory
SCRIPT="$0"
if [ ! -d "${APP_DIR}" ]; then
  APP_DIR=`dirname "$SCRIPT"`/../..
  APP_DIR=`cd "${APP_DIR}"; pwd`
fi

# Setup the gapic-generator executable
executable="./build/libs/gapic-generator-latest-fatjar.jar"
cd $APP_DIR && ./gradlew clean && ./gradlew fatjar

# Ensure output directory is empty
if [ -d "${APP_DIR}/tmp/ruby-showcase" ] ; then
  rm -rf ${APP_DIR}/tmp/ruby-showcase
fi

# Invoke gapic-generator
java -cp $executable com.google.api.codegen.GeneratorMain LEGACY_GAPIC_AND_PACKAGE \
--descriptor_set=$APP_DIR/src/test/java/com/google/api/codegen/testsrc/showcase.desc \
--package_yaml2=$APP_DIR/src/test/java/com/google/api/codegen/testsrc/showcase_pkg2.yaml \
--output=$APP_DIR/showcase/ruby/ \
--language=ruby \
--service_yaml=$APP_DIR/src/test/java/com/google/api/codegen/testsrc/showcase.yaml \
--gapic_yaml=$APP_DIR/src/test/java/com/google/api/codegen/testsrc/showcase_gapic.yaml

