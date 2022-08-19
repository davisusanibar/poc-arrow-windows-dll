#!/usr/bin/env bash

set -ex
echo "inicio"
echo "$(uname -s)"
echo "$(uname -m)"
if [[ "$(uname -s)" == "Linux" ]] && [[ "$(uname -m)" == "s390x" ]]; then
  # Since some files for s390_64 are not available at maven central,
  # download pre-build files from Artifactory and install them explicitly
  mvn_install="mvn install:install-file"
  wget="wget"
  artifactory_base_url="https://apache.jfrog.io/artifactory/arrow"

  artifactory_dir="protoc-binary"
  group="com.google.protobuf"
  artifact="protoc"
  ver="21.2"
  classifier="linux-s390_64"
  extension="exe"
  # target=${artifact}-${ver}-${classifier}.${extension}
  target=${artifact}
  ${wget} ${artifactory_base_url}/${artifactory_dir}/${ver}/${target}
  ${mvn_install} -DgroupId=${group} -DartifactId=${artifact} -Dversion=${ver} -Dclassifier=${classifier} -Dpackaging=${extension} -Dfile=$(pwd)/${target}
  # protoc requires libprotoc.so.* libprotobuf.so.*
  libver="32"
  ${wget} ${artifactory_base_url}/${artifactory_dir}/${ver}/libprotoc.so.${libver}
  ${wget} ${artifactory_base_url}/${artifactory_dir}/${ver}/libprotobuf.so.${libver}
  mkdir -p ${ARROW_HOME}/lib
  cp lib*.so.${libver} ${ARROW_HOME}/lib
  export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${ARROW_HOME}/lib

  artifactory_dir="protoc-gen-grpc-java-binary"
  group="io.grpc"
  artifact="protoc-gen-grpc-java"
  ver="1.47.0"
  classifier="linux-s390_64"
  extension="exe"
  # target=${artifact}-${ver}-${classifier}.${extension}
  target=${artifact}
  ${wget} ${artifactory_base_url}/${artifactory_dir}/${ver}/${target}
  ${mvn_install} -DgroupId=${group} -DartifactId=${artifact} -Dversion=${ver} -Dclassifier=${classifier} -Dpackaging=${extension} -Dfile=$(pwd)/${target}
fi
echo "hi"
#mvn="mvn -B -DskipTests -D'rat.skip'=true -D'org.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener'=warn -T 2C"
mvn="mvn -B -DskipTests -Drat.skip=true -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn"
# Use `2 * ncores` threads
mvn="${mvn} -T 2C"
${mvn} install
