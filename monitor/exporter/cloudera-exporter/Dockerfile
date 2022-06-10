FROM zhufuyi/alpine:cst

LABEL maintainer="zhuyasen zhuyasen@126.com"

COPY ./cloudera-exporter /app/cloudera-exporter
RUN chmod +x /app/cloudera-exporter
WORKDIR /app/
CMD ./cloudera-exporter --config-file=config/config.ini
