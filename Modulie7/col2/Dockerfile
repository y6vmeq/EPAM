FROM centos
MAINTAINER Aliaksandr Padrabkinkin <y6vmeq@gmail.com>
RUN yum update -y && yum upgrade -y && yum  clean all
RUN yum install epel-release -y
RUN yum install collectd -y
COPY myinfluxdb.conf /etc/collectd.d/myinfluxdb.conf
ENTRYPOINT ["/sbin/collectd"]
CMD ["-f"]