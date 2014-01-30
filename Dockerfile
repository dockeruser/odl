from    ubuntu:12.04

run     echo "deb http://archive.ubuntu.com/ubuntu precise main universe multiverse" > /etc/apt/sources.list
run     apt-get update

# workaround fuse bug
run     apt-get -y install fuse  || :
run     rm -rf /var/lib/dpkg/info/fuse.postinst
run     apt-get -y install fuse

run     apt-get install -y openjdk-7-jdk

run     apt-get install -y vim wget net-tools unzip
run     apt-get install -y less
run     update-alternatives --set java /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java

run     wget -O /opt/serviceprovider.zip "http://nexus.opendaylight.org/service/local/artifact/maven/content?r=opendaylight.snapshot&g=org.opendaylight.integration&a=distributions-serviceprovider&v=0.1.1-SNAPSHOT&p=zip&c=osgipackage"


run     unzip /opt/serviceprovider.zip -d /opt

expose  8080 6633 1830 8383
cmd     /opt/opendaylight/run.sh -Xmx1g
