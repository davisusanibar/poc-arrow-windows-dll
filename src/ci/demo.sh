#!/usr/bin/env bash

set -ex
if [[ "$(uname -s)" == "Linux" ]] && [[ "$(uname -m)" == "s390x" ]]; then
fi

mvn="mvn -B -DskipTests -D'rat.skip'=true -D'org.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener'=warn -T 2C"

${mvn} install