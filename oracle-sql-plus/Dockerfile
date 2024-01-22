FROM ghcr.io/oracle/oraclelinux8-instantclient:19

RUN yum-config-manager --setopt=sslverify=false --save && \
    yum -y install oracle-epel-release-el8.x86_64 && \
    yum -y install rlwrap

RUN dnf -y install oracle-instantclient19.21-tools

RUN ln -s /usr/lib/oracle/19.21/client64/bin/impdp /bin/impdp

