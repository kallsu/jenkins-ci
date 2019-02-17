ARG JENKINS_VERSION=latest

FROM jenkins/jenkins:${JENKINS_VERSION}

USER root

RUN apt-get update && \
    apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg > /tmp/dkey && \ 
    apt-key add /tmp/dkey && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" && \
    apt-get update && \
    apt-get -y install docker-ce && \
    apt-get -y install apt-utils openssh-server openssh-client && \
    apt-get -y upgrade

USER jenkins

# redefine the entrypoint of jenkins image
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]
