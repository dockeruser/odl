from    ubuntu:12.04

run     echo "deb http://archive.ubuntu.com/ubuntu precise main universe multiverse" > /etc/apt/sources.list
run     apt-get update

# workaround fuse bug
run     apt-get -y install fuse  || :
run     rm -rf /var/lib/dpkg/info/fuse.postinst
run     apt-get -y install fuse

run     apt-get install -y openjdk-7-jdk

run     apt-get install -y vim wget net-tools unzip maven
run     apt-get install -y less

run     mvn org.apache.maven.plugins:maven-dependency-plugin:2.8:get -Dartifact=org.opendaylight.integration:distributions-serviceprovider:0.1.1-SNAPSHOT:zip:osgipackage -DremoteRepositories=http://nexus.opendaylight.org/content/repositories/opendaylight.snapshot/ -Dtransitive=false
 
 

run     unzip `find /root/.m2/ -name '*.zip' | head -n 1` -d /opt

expose  8080 6633 1830 8383
cmd     /opt/opendaylight/run.sh
