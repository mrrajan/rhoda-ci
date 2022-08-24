FROM quay.io/centos/centos:stream8

# Use this build arg to set any default test script arguments
ENV RUN_SCRIPT_ARGS=${RUN_SCRIPT_ARGS}
ENV ROBOT_EXTRA_ARGS=${ROBOT_EXTRA_ARGS}
ENV HOME /tmp

## Install supporting libraries and driver
RUN dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm &&\
    dnf install -y python38 jq git unzip chromium chromedriver redhat-lsb-core &&\
    dnf clean all

## Install oc in the container
RUN curl -L https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable/openshift-client-linux.tar.gz -o $HOME/oc_client.tar.gz && \
    tar xvf $HOME/oc_client.tar.gz -C /usr/local/bin/ && \
    rm -rf $HOME/oc_client.tar.gz && rm /usr/local/bin/README.md

RUN chmod 755 /usr/local/bin/oc &&\
         oc version --client

## Install OCM in the container
RUN curl -L  https://github.com/openshift-online/ocm-cli/releases/download/v0.1.64/ocm-linux-amd64 -o /usr/local/bin/ocm
RUN chmod 755 /usr/local/bin/ocm && ocm version

# Create and Change the WORKDIR so the run script references any files/folders from the root of the repo
RUN mkdir $HOME/rhoda-ci
WORKDIR $HOME/rhoda-ci
COPY tests tests/
COPY libs libs/
COPY resources resources/
COPY utils utils/
COPY test-variables.yaml .
COPY requirements.txt run_robot_test.sh setup.py .
COPY run_robot_test.sh .
RUN chmod +x run_robot_test.sh
RUN python3 --version
RUN python3 -m venv venv && source venv/bin/activate && pip3 install --upgrade pip && venv/bin/pip3 install -r requirements.txt

# Set the group ownership so non-root users can write to rhoda-ci directory
RUN groupadd --gid 1001 rhoda-ci-users
RUN useradd -r -u 1001 -g rhoda-ci-users rhoda-ci-runner
RUN chgrp -R 1001 $HOME/rhoda-ci && chown -R 1001 $HOME/rhoda-ci && chmod -R 744 $HOME/rhoda-ci
USER 1001

ENTRYPOINT ["./run_robot_test.sh","-s","-x"]
