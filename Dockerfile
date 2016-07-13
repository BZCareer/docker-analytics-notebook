FROM docker.io/anapsix/docker-oracle-java8

MAINTAINER Zak Hassan zak.hassan1010@gmail.com

RUN wget http://mirror.csclub.uwaterloo.ca/apache/zeppelin/zeppelin-0.6.0/zeppelin-0.6.0-bin-netinst.tgz && tar xvzf zeppelin-0.6.0-bin-netinst.tgz -C /usr/local/  && rm zeppelin-0.6.0-bin-netinst.tgz
RUN wget http://d3kbcqa49mib13.cloudfront.net/spark-1.6.1-bin-hadoop2.6.tgz && tar xvzf spark-1.6.1-bin-hadoop2.6.tgz -C /usr/local/  && rm spark-1.6.1-bin-hadoop2.6.tgz

RUN cd /usr/local &&  mv /usr/local/zeppelin-0.6.0-bin-netinst/   /usr/local/zeppelin
RUN cd /usr/local &&  mv /usr/local/spark-1.6.1-bin-hadoop2.6/   /usr/local/spark

# CREATE PASSWORDLESS login
RUN apt-get install ssh -y
RUN mkdir ~/.ssh && chmod 700 ~/.ssh
RUN  touch /root/.ssh/config && touch /root/.ssh/authorized_keys && touch /usr/local/spark/conf/slaves && echo "localhost" >> /usr/local/spark/conf/slaves

RUN cd ~/.ssh && ssh-keygen -f id_rsa -t rsa -N ''

RUN chmod 700 ~/.ssh/authorized_keys && chmod 700 ~/.ssh/id_rsa &&  chmod 700 ~/.ssh/id_rsa

ENV ZEPPELIN_PORT 9999
ENV ZEPPELIN_HOME   /usr/local/zeppelin
ENV SPARK_HOME   /usr/local/spark

COPY entrypoint.sh /etc/entrypoint.sh

COPY zeppelin-site.xml    /usr/local/zeppelin/conf/zeppelin-site.xml
COPY zeppelin.conf  /etc/security/limits.d/zeppelin.conf
COPY limits.conf /etc/security/limits.conf

RUN sysctl -p

ENV PATH $PATH:$ZEPPELIN_HOME/bin:$SPARK_HOME/sbin

EXPOSE  9999 18080 8080 7077 22

ENTRYPOINT ["/etc/entrypoint.sh"]
