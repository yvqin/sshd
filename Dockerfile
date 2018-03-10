FROM alpine:latest
MAINTAINER wb_jian  <wb_jian@qq.com> 
  
RUN apk add --update tzdata openssh rsync apk-cron
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN /bin/echo "Asia/Shanghai" > /etc/timezone
RUN apk del tzdata && rm -f /var/cache/apk/*
RUN mkdir /data

ENV LANG="zh_CN.UTF-8" \
		ROOT_PASSWORD="root" \
		CRON_TIME="*/10 * * * * " \
		SRC_DIR="/data/" \
		TARGET_DIR="/backup" 

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /*.sh

EXPOSE 22

ENTRYPOINT ["sh", "/entrypoint.sh"] 