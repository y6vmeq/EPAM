FROM centos
MAINTAINER Aliaksandr Padrabkinkin <y6vmeq@gmail.com>
RUN yum update -y && yum upgrade -y && yum clean all
RUN yum install mc -y
RUN yum install https://dl.grafana.com/oss/release/grafana-5.4.2-1.x86_64.rpm -y
COPY grafana.ini /etc/grafana/grafana.ini
COPY datasource.yaml /usr/share/grafana/conf/provisioning/datasources/datasource.yaml
COPY dashboard.yaml /usr/share/grafana/conf/provisioning/dashboards/dashboard.yaml
COPY dashboard.json /usr/share/grafana/conf/provisioning/dashboards/json/dashboard.json
ENTRYPOINT ["/usr/sbin/grafana-server"]
CMD ["--config=/etc/grafana/grafana.ini", "--homepath=/usr/share/grafana"]