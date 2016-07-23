FROM ubuntu:trusty
MAINTAINER ihciah <ihciah@gmail.com>

COPY vpn_run /vpn_run
RUN chmod a+x /vpn_run
WORKDIR /etc/ocserv

ENV DEPENDENCIES build-essential wget xz-utils libgnutls28-dev gnutls-bin libev-dev libwrap0-dev libpam0g-dev libseccomp-dev libreadline-dev libnl-route-3-dev libkrb5-dev liboath-dev libprotobuf-c0-dev libtalloc-dev libhttp-parser-dev libpcl1-dev libopts25-dev autogen pkg-config nettle-dev protobuf-c-compiler gperf liblockfile-bin nuttcp lcov iptables

ENV REMOVEPACKEGS build-essential wget pkg-config protobuf-c-compiler

RUN chmod a+x /vpn_run && apt-get update && apt-get install -y $DEPENDENCIES \
	&& cd /root && wget https://github.com/Cyan4973/lz4/releases/latest -o lz4.html && export lz4_version=$(cat lz4.html | grep -m 1 -o 'r[0-9][0-9][0-9]') \
	&& wget https://github.com/Cyan4973/lz4/archive/$lz4_version.tar.gz && tar xvf $lz4_version.tar.gz && cd lz4-$lz4_version && make install && ln -sf /usr/local/lib/liblz4.* /usr/lib/ \
	&& wget http://www.infradead.org/ocserv/download.html && export ocserv_version=$(cat download.html | grep -o '[0-9]*\.[0-9]*\.[0-9]*') \
	&& cd /root && wget ftp://ftp.infradead.org/pub/ocserv/ocserv-$ocserv_version.tar.xz && tar xvf ocserv-$ocserv_version.tar.xz \
	&& cd ocserv-$ocserv_version && sed -i 's/define DEFAULT_CONFIG_ENTRIES 96/define DEFAULT_CONFIG_ENTRIES 200/g' src/vpn.h  \
    && ./configure --prefix=/usr --sysconfdir=/etc --with-local-talloc && make && make install \
	&& rm -rf /root/* \
	&& apt-get --purge autoremove -y $REMOVEPACKEGS \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/vpn_run"]
