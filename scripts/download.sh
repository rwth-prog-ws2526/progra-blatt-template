#!/bin/sh

# be sure to call this script from the project root directory

# create the directory

mkdir -p .tools

# Download the .jar for tests

curl -sSL -o .tools/junit-platform-console-standalone-6.0.0.jar \
  "https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/6.0.0/junit-platform-console-standalone-6.0.0.jar"
