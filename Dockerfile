FROM alpine:latest
COPY ./ch_sftpuser_passwd /usr/bin/
RUN apk --no-cache add openssh openssh-sftp-server && \
    addgroup -g 1000 sftpgroup &&\
    yes "changeit" | adduser -g "SFTP User" -h "/home/sftpuser" -u 1000 -G sftpgroup sftpuser &&\
    chmod u+xs /usr/bin/ch_sftpuser_passwd
USER sftpuser
EXPOSE 22
CMD ["/bin/sh", "-c", "ch_sftpuser_passwd \"$SFTP_PASSWORD\" && /usr/sbin/sshd -D"]
