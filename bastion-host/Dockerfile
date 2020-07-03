FROM centos:7

MAINTAINER k3s Team

RUN yum -y update && \
    yum -y install httpd nmap vim git htop openssh-server openssh-clients epel-release
RUN yum -y update
RUN yum -y install ansible && \
    yum clean all

COPY users /tmp
COPY playbook.yml /tmp

RUN chmod +x /tmp/users

# RUN mkdir -p /root/.ssh/

# RUN ssh-keygen

ENTRYPOINT ["bin/bash"]
# RUN users

# RUN mkdir /root/.ssh/ && \
#     echo "ssh-rsa ..." > ~/.ssh/authorized_keys && \
#     chmod 700 ~/.ssh && \
#     chmod 600 ~/.ssh/authorized_keys

