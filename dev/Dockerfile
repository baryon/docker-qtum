FROM ubuntu:16.04
MAINTAINER baryon (lilong@gmail.com)

RUN groupadd -r qtum && useradd -r -m -g qtum qtum

RUN set -ex \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends git gosu wget apt-utils \
	&& apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils \
	&& apt-get install -y libboost-all-dev \
	&& apt-get install -y software-properties-common \
	&& add-apt-repository -y ppa:bitcoin/bitcoin \
	&& apt-get update \
	&& apt-get install -y libdb4.8-dev libdb4.8++-dev \
	&& apt-get install -y libzmq3-dev \
 	&& rm -rf /var/lib/apt/lists/*

RUN cd /tmp && git clone --recursive https://github.com/qtumproject/qtum.git \
	&& cd qtum \
	&& ./autogen.sh \
	&& ./configure --without-gui \
	&& make \
	&& make check \
	&& make install  \
	&& rm -rf /tmp/* 

ENV QTUM_DATA /data

# create data directory
RUN mkdir -p /data \
	&& chown -R qtum:qtum /data \
	&& ln -sfn /data /home/qtum/.qtum \
	&& chown -h qtum:qtum /home/qtum/.qtum
VOLUME /data

#https://stackoverflow.com/questions/38882654/docker-entrypoint-running-bash-script-gets-permission-denied/41571589#41571589
#you must have permission to run. If not then try: `chmod +x docker-entrypoint.sh`
COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8332 8333 18332 18333
CMD ["qtumd"]
