FROM jenkins/jenkins:lts
USER root
RUN apt-get update && apt-get -y install lsb-release \ 
    apt-transport-https ca-certificates curl \
    gnupg2 software-properties-common
RUN curl -fsSLo /usr/share/keyrings/githubcli-archive-keyring.gpg https://cli.github.com/packages/githubcli-archive-keyring.gpg 
RUN echo "deb [arch=$(dpkg --print-architecture) \
    signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] \
    https://cli.github.com/packages \
    $(lsb_release -cs) main" > /etc/apt/sources.list.d/github-cli.list
RUN apt install wget -y && \
    wget https://github.com/snyk/snyk/releases/download/v1.667.0/snyk-linux && \
    chmod +x snyk-linux && \
    mv snyk-linux /usr/local/bin/snyk
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
    https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
    signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
    https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce 
USER jenkins
RUN usermod -aG docker jenkins
RUN jenkins-plugin-cli --plugins "docker-workflow nodejs snyk-security-scanner"