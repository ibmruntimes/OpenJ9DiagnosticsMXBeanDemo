#!/bin/bash
#
# (C) Copyright IBM Corporation 2018, 2018
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

script_dir="$(pwd)"

# Clone the open liberty repository containing the docker file
git clone git@github.com:OpenLiberty/ci.docker.git

# Modify the java build to adoptopenjdk openjdk8 openj9 nightly build that contains the OpenJ9DiagnosticsMXBean 
pushd $script_dir/ci.docker/release/kernel/java8/openj9
`sed -ie 's/FROM adoptopenjdk\/openjdk8-openj9/FROM adoptopenjdk\/openjdk8-openj9\:nightly/g' Dockerfile`
chmod +x docker-server
# Build the liberty docker image
docker build -t liberty-openjdk8-openj9 .
[ "$?" != "0" ] && echo "Docker build of liberty failed."
popd

# Cleanup the cloned repo 
rm -rf ci.docker

# Build the HelloWorldServlet using Maven
pushd $script_dir/HelloWorldServlet
mvn clean install
popd

# Build the Demo application docker image
docker build -t helloworld-openjdk8-mxbean .

