FROM gocd/gocd-agent-centos-7:v17.6.0
MAINTAINER Steve Wade <steven@stevenwade.co.uk>

ARG git_repository="Unknown"
ARG git_commit="Unknown"
ARG git_branch="Unknown"
ARG built_on="Unknown"

LABEL git.repository=$git_repository
LABEL git.commit=$git_commit
LABEL git.branch=$git_branch
LABEL build.dockerfile=/Dockerfile
LABEL build.on=$built_on

COPY ./Dockerfile /Dockerfile

RUN yum install wget -y && \
    yum groupinstall 'Development Tools' -y

# Add docker to the agent
ENV DOCKER_VERSION=17.03.1
RUN curl --silent -O https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VERSION-ce.tgz && \
    tar xzf docker-*.tgz && \
    mv docker/docker /usr/local/bin/docker && \
    rm -rf docker