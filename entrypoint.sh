#!/bin/sh

set -o errexit
set -o pipefail

RUN_PATH="/app"
CP_PATH="."
ARGS=""

if [ "$FROM_ROOT" = "1" ]; then
  CP_PATH=$RUN_PATH
  RUN_PATH="/"
fi
echo "Running from '$RUN_PATH', CLASSPATH prefix is '$CP_PATH'"

if [ "$CLI_IMPORT" = "1" ]; then
  ARGS="-Dspring.config.import=configserver:"
  TMP=$(grep -v 'config.import' application.yml) && echo "$TMP" > application.yml
  echo "Using config.import from command line"
else
  echo "Using config.import from application.yml"
fi

cd $RUN_PATH
echo "Running 'java $ARGS -cp $CP_PATH:$CP_PATH/lib/* com.example.ExampleApplication'"
exec java $ARGS -cp $CP_PATH:$CP_PATH/lib/* com.example.ExampleApplication
