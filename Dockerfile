from    dockeruser/oracle-java7

run     echo "deb http://archive.ubuntu.com/ubuntu precise main universe multiverse" > /etc/apt/sources.list
run     apt-get update

run     apt-get install -y vim wget net-tools unzip maven
run     apt-get install -y less

run     mvn org.apache.maven.plugins:maven-dependency-plugin:2.8:get -Dartifact=org.opendaylight.controller:distribution.opendaylight:0.1.1-SNAPSHOT:zip:osgipackage -DremoteRepositories=http://nexus.opendaylight.org/content/repositories/opendaylight.snapshot/ -Dtransitive=false

run     unzip `find /root/.m2/ -name '*.zip' | head -n 1` -d /opt

expose  8080 6633 1830 8383
cmd     /opt/opendaylight/run.sh
