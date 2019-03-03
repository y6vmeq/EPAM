FROM centos
MAINTAINER Aliaksandr Padrabkinkin <y6vmeq@gmail.com>
RUN yum update -y && yum upgrade -y && yum clean all
RUN yum install https://dl.grafana.com/oss/release/grafana-5.4.2-1.x86_64.rpm -y
ENTRYPOINT ["/usr/sbin/grafana-server"]
CMD ["--config=/etc/grafana/grafana.ini", "--homepath=/usr/share/grafana"]