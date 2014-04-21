FROM ubuntu:latest

MAINTAINER Kazuyuki Honda <hakobera@gmail.com>

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y openssh-server supervisor curl dstat
RUN cd /tmp/ && wget http://s3.amazonaws.com/influxdb/influxdb_latest_amd64.deb && dpkg -i influxdb_latest_amd64.deb
RUN curl -L http://toolbelt.treasuredata.com/sh/install-ubuntu-precise.sh | sh

RUN mkdir -p /var/run/sshd
RUN echo 'root:pass' | chpasswd

RUN /usr/lib/fluent/ruby/bin/fluent-gem install fluent-plugin-dstat fluent-plugin-influxdb fluent-plugin-dstat fluent-plugin-flatten-hash fluent-plugin-map --no-ri --no-rdoc
ADD td-agent.conf /etc/td-agent/td-agent.conf

RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 22 8083 8086
CMD ["/usr/bin/supervisord"]
