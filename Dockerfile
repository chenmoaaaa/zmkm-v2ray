#FROM ubuntu
FROM debian:latest

WORKDIR /root
COPY . .

RUN apt-get update \
  && apt-get install -y iptables --no-install-recommends

RUN mkdir /var/log/v2ray/ \
  && chmod +x /root/v2ray \
  && chmod +x /root/entrypoint.sh

EXPOSE 10086

CMD ["/root/entrypoint.sh"]

