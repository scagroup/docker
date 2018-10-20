FROM debian

MAINTAINER Konstantin Lebedev <scagroup@yandex.ru>

ENV PATH="${PATH}:/var/www/:/var/www/.local:/var/www/.local/bin"

WORKDIR /var/www/www-root/data

RUN chmod 777 /var/run/

RUN apt-get update -yyq &&  apt-get upgrade -yyq &&  apt-get install openssh-server -yyq grep nano -yyq  grep supervisor -yyq

RUN mkdir -p /var/run/sshd /var/log/supervisor

RUN echo 'root:9379992' | chpasswd

RUN sed -i -e 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' -e 's/#Port 22/Port 222/' /etc/ssh/sshd_config

#RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

COPY supervisor.conf /etc/supervisor/conf.d/supervisor.conf

#RUN rm /root/.ssh/

#RUN chmod 777 /root

#RUN mkdir /root/.ssh/

#RUN chmod 700 /root/.ssh/

#RUN echo "localhost" >> /root/.ssh/known_hosts

#RUN ssh-keygen -f /root/.ssh -yyq

#RUN ssh-keygen -yyq

#RUN passwd -i 7262238 root
 
EXPOSE 222

CMD ["/usr/bin/supervisord"]
