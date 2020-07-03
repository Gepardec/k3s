FROM centos:7

MAINTAINER k3s Team

RUN yum -y update && \
    yum -y install httpd nmap vim git htop openssh-server openssh-clients ansible && \
    yum clean all

COPY users /tmp
RUN chmod +x /tmp/users

ENTRYPOINT ["bin/bash"]

# RUN adduser

# RUN ssh-keygen ...

# RUN mkdir /root/.ssh/ && \
#     echo "ssh-rsa ..." > ~/.ssh/authorized_keys && \
#     chmod 700 ~/.ssh && \
#     chmod 600 ~/.ssh/authorized_keys
#      .
#      .
#      .

