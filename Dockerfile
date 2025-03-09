FROM alpine:latest
LABEL maintainer="wurzag"
LABEL description="tftp for cisco 8861 3rd party control"

RUN apk --no-cache add tftp-hpa
RUN mkdir /data && \
    addgroup -S tftpd && \
    adduser -s /bin/false -S -D -H -h /data -G tftpd tftpd

COPY overlay/ /
COPY data/* /data/
VOLUME /data
EXPOSE 69/udp

RUN ["chmod", "+x", "/docker-entrypoint.sh"]
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/in.tftpd", "-L", "-v", "-s", "-u", "tftpd", "/data"]
