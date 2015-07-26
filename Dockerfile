FROM sunyi00/centos-python:1.0.0

RUN yum install -y ndjbdns \
    && yum -y clean all \
    && pip install supervisor \
    && mkdir -p /var/log/supervisor \
    && mkdir -p /var/log/tinydns \
    && mkdir -p /var/log/dns-creator

VOLUME ["/var/log/supervisor"]
VOLUME ["/var/log/tinydns"]
VOLUME ["/var/log/dns-creator"]

## Configure tinydns
# users
RUN useradd -s /bin/false tinydns && \
	useradd -s /bin/false axfrdns && \
	useradd -s /bin/false dnslog
# config dir
RUN tinydns-conf tinydns dnslog /etc/tinydns 0.0.0.0
## Configure axfrdns
# config dir and service
RUN axfrdns-conf axfrdns dnslog /etc/axfrdns /etc/tinydns 0.0.0.0

## Docker config
EXPOSE 53/udp 
EXPOSE 53
