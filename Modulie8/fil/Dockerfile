FROM centos
MAINTAINER Aliaksandr Padrabkinkin <y6vmeq@gmail.com>
RUN yum update -y && yum upgrade -y && yum  clean all
RUN yum install epel-release -y
RUN yum install collectd -y
COPY myinfluxdb.conf /etc/collectd.d/myinfluxdb.conf
CMD ["/sbin/collectd -f"]
RUN yum install https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.6.1-x86_64.rpm -y
COPY filebeat.yml /etc/filebeat/filebeat.yml
ENTRYPOINT ["filebeat"]
CMD ["run"]