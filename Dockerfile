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



FROM liberty-openjdk8-openj9 

MAINTAINER Chandrakala <chandra-ms@in.ibm.com> (@chandrams)

ENV JVM_ARGS="-Xdump:dynamic"
COPY server.xml /opt/ol/wlp/usr/servers/defaultServer/
COPY HelloWorldServlet/target/HelloWorldServlet-1.war /opt/ol/wlp/usr/servers/defaultServer/dropins/HelloWorld.war
COPY keystore.jks  /opt/ol/wlp/usr/servers/defaultServer/resources/security/keystore.jks

ENV LICENSE accept
CMD ["/opt/ol/wlp/bin/server", "run", "defaultServer"]
