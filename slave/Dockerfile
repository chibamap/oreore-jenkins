FROM alpine:3.5

RUN apk add --update bash docker openssh

RUN ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key && \
     ssh-keygen -t dsa -N "" -f /etc/ssh/ssh_host_dsa_key

RUN mkdir -m 700 /root/.ssh

COPY ./id_key.pub /root/.ssh/authorized_keys

RUN chmod -R 600 /root/.ssh/*


EXPOSE 22
CMD /usr/sbin/sshd -D
