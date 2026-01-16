FROM debian:13-slim

LABEL org.opencontainers.image.title="Grand Theft Auto: Connected"
LABEL org.opencontainers.image.description="Docker image for Grand Theft Auto: Connected"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y --no-install-recommends \
        wget \
        ca-certificates \
        tar \
        libmariadb3 \
    && rm -rf /var/lib/apt/lists/*

RUN ln -sf /usr/lib/x86_64-linux-gnu/libmariadb.so.3 \
           /usr/lib/x86_64-linux-gnu/libmysqlclient.so.18

WORKDIR /opt/gtac

RUN wget -O gtac-server.tar.gz https://gtaconnected.com/downloads/server/GTAC-Server-Linux-1.7.1.tar.gz && \
    tar -xzf gtac-server.tar.gz && \
    rm gtac-server.tar.gz

RUN mkdir -p /opt/gtac/modules && \
    wget -O /opt/gtac/modules/mod_mysql.so https://github.com/VortrexFTW/mod_mysql/releases/download/1.5/mod_mysql.so && \
sed -i '/<modules>/a\\t\t<module src="modules/mod_mysql" />' /opt/gtac/server.xml

VOLUME ["/data"]
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 22003
CMD ["./Server"]