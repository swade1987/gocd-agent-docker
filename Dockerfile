FROM openjdk:8
MAINTAINER Steven Wade <steven@stevenwade.co.uk>

ENV GOCD_VERSION 17.4.0-4892
ENV GOCD_DISTR go-agent.deb

ENV KUBECTL_VERSION 1.6.4
ENV HELM_VERSION v2.4.2

# Install GoCD Agent
RUN curl -fSL https://download.gocd.io/binaries/${GOCD_VERSION}/deb/go-agent_${GOCD_VERSION}_all.deb -o $GOCD_DISTR \
    && dpkg -i $GOCD_DISTR \
    && rm $GOCD_DISTR

RUN mkdir /home/go && usermod -d /home/go go
VOLUME /var/lib/go-agent

# Include necessary agent configuration.
ADD autoregister.properties /var/lib/go-agent/config/

# Install Kubectl.
RUN cd /usr/local/bin && \
    wget --quiet https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    chmod +x kubectl

# Install Helm.
RUN wget -O - https://kubernetes-helm.storage.googleapis.com/helm-${HELM_VERSION}-linux-amd64.tar.gz | tar -zx \
    && mv linux-amd64/helm /bin/helm \
    && rm -rf linux-amd64

# Adding the entrypoint script to run GoCD
COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["go-agent"]