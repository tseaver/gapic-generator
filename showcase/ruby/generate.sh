#!/bin/bash

# Move to the top level directory
SCRIPT="$0"
if [ ! -d "${APP_DIR}" ]; then
  APP_DIR=`dirname "$SCRIPT"`/../..
  APP_DIR=`cd "${APP_DIR}"; pwd`
fi

# Setup the gapic-generator executable
executable="./build/libs/gapic-generator-latest-fatjar.jar"
if [ ! -f "$executable" ]
then
  cd $APP_DIR && ./gradlew fatjar
fi

# Ensure protoc is installed
if [ -n `which protoc` ] ; then
  PROTOCCMD="protoc"
else
  die "ERROR: 'protoc' command could not be found in your PATH.

Please install protoc."
fi

# Setup temporary directories
if [ ! -d "${APP_DIR}/tmp" ] ; then
  mkdir "${APP_DIR}/tmp"
fi
if [ ! -d "${APP_DIR}/tmp/googleapis" ] ; then
  git clone https://github.com/googleapis/googleapis.git $APP_DIR/tmp/googleapis
fi
if [ ! -d "${APP_DIR}/tmp/googleapis/google/showcase" ] ; then
  mkdir -p ${APP_DIR}/tmp/googleapis/google/showcase/v1
  cp $APP_DIR/src/test/java/com/google/api/codegen/testsrc/showcase.proto ${APP_DIR}/tmp/googleapis/google/showcase/v1
  cp $APP_DIR/src/test/java/com/google/api/codegen/testsrc/showcase.yaml ${APP_DIR}/tmp/googleapis/google/showcase
fi

# Invoke protoc to generate descriptor set
protoc --proto_path=$APP_DIR/tmp/googleapis \
--proto_path=$APP_DIR/build/toolpaths/protobufJavaDir \
--include_imports \
--include_source_info \
-o $APP_DIR/tmp/google-cloud-showcase-v1.desc \
${APP_DIR}/tmp/googleapis/google/showcase/v1/showcase.proto

# Ensure output directory is empty
if [ -d "${APP_DIR}/tmp/ruby-showcase" ] ; then
  rm -rf ${APP_DIR}/tmp/ruby-showcase
fi

# Invoke gapic-generator
java -cp $executable com.google.api.codegen.GeneratorMain LEGACY_GAPIC_AND_PACKAGE \
--descriptor_set=$APP_DIR/tmp/google-cloud-showcase-v1.desc \
--package_yaml2=$APP_DIR/src/test/java/com/google/api/codegen/testsrc/showcase_pkg2.yaml \
--output=$APP_DIR/tmp/ruby-showcase \
--language=ruby \
--service_yaml=${APP_DIR}/tmp/googleapis/google/showcase/showcase.yaml \
--gapic_yaml=$APP_DIR/src/test/java/com/google/api/codegen/testsrc/showcase_gapic.yaml

# Copy generated files to showcase directory
cp -rf ${APP_DIR}/tmp/ruby-showcase/* ${APP_DIR}/showcase/ruby/
