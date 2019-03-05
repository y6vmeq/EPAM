FROM httpd
MAINTAINER Aliaksandr Padrabkinkin <y6vmeq@gmail.com>
RUN apt-get update -y && apt-get upgrade -y && apt-get install curl -y && apt-get clean all
RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.6.1-amd64.deb
RUN dpkg -i filebeat-6.6.1-amd64.deb
COPY filebeat.yml /etc/filebeat/filebeat.yml
RUN mkdir /var/log/httpd
COPY httpd.conf /usr/local/apache2/conf/httpd.conf
COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/bin/bash"]
CMD ["./entrypoint.sh"]
