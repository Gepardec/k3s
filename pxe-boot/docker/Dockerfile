FROM centos:7

MAINTAINER office@gepardec.com

ARG PXE_DEPS="dnsmasq vim"

USER root

RUN echo "yum update -y \
    && yum install -y ${PXE_DEPS} \
    && yum clean all"

COPY work/ifcfg-eth0 etc/sysconfig/network-scripts/ifcfg-eth0

RUN echo -e "\nUUID=$(uuidgen eth0)" >> etc/sysconfig/network-scripts/ifcfg-eth0

ENTRYPOINT ["/bin/bash"]