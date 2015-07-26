FROM sunyi00/centos-python:1.0.0

RUN mkdir -p /root/dns \
    && cd /root/dns \
    && curl -O http://cr.yp.to/ucspi-tcp/ucspi-tcp-0.88.tar.gz \
    && curl -O http://cr.yp.to/daemontools/daemontools-0.76.tar.gz \
    && curl -O http://cr.yp.to/djbdns/djbdns-1.05.tar.gz \
    && tar -xzf ucspi-tcp-0.88.tar.gz \
    && tar -xzf djbdns-1.05.tar.gz \
    && mkdir -p /package \
    && chmod 1755 /package \
    && cd /package \
    && tar -xzf /root/dns/daemontools-0.76.tar.gz \
    && cd admin/daemontools-0.76/ \
    && echo gcc -O2 -include /usr/include/errno.h > src/conf-cc \
    && package/install \
    && cd /root/dns/ucspi-tcp-0.88 \
    && echo gcc -O2 -include /usr/include/errno.h > conf-cc \
    && make setup check \
    && cd ../djbdns-1.05 \
    && echo gcc -O2 -include /usr/include/errno.h > conf-cc \
    && make setup check \
    && useradd -s /bin/false tinydns \
    && useradd -s /bin/false axfrdns \
    && useradd -s /bin/false dnslog \
    && tinydns-conf tinydns dnslog /etc/tinydns 0.0.0.0 \
    && axfrdns-conf axfrdns dnslog /etc/axfrdns /etc/tinydns 0.0.0.0

RUN pip install supervisor \
    && mkdir -p /var/log/supervisor \
    && mkdir -p /var/log/tinydns \
    && mkdir -p /var/log/dns-creator

VOLUME ["/var/log/supervisor"]
VOLUME ["/var/log/tinydns"]
VOLUME ["/var/log/dns-creator"]

EXPOSE 53/udp 
EXPOSE 53
