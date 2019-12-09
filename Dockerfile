FROM debian:buster

MAINTAINER foxcris

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales && apt-get clean
RUN sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="de_DE.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=de_DE.UTF-8

ENV LANG de_DE.UTF8
RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get install -y nano less anacron dirvish unattended-upgrades && apt-get clean

RUN mv /etc/dirvish /etc/dirvish_default
RUN mkdir /etc/dirvish
RUN touch /var/log/cron.log

VOLUME /etc/dirvish
VOLUME /var/log
VOLUME /root
VOLUME /backup

COPY docker-entrypoint.sh /
RUN chmod 755 /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
