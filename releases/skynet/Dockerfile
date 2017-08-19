FROM debian:stretch-slim
MAINTAINER baryon (lilong@gmail.com)

RUN groupadd -r qtum && useradd -r -m -g qtum qtum

RUN set -ex \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu gpg wget \
	&& rm -rf /var/lib/apt/lists/*


ENV QTUM_VERSION 0.14.0
ENV QTUM_URL https://github.com/qtumproject/qtum/releases/download/testnet-skynet/qtum-0.14.0-x86_64-linux-gnu.tar.gz

# install qtum binaries
RUN set -ex \
	&& QTUM_DIST=$(basename $QTUM_URL) \
	&& wget -qO $QTUM_DIST $QTUM_URL \
	&& tar -xzvf $QTUM_DIST -C /usr/local --strip-components=1 --exclude=*-qt \
	&& rm qtum*

# create data directory
ENV QTUM_DATA /data
RUN mkdir $QTUM_DATA \
	&& chown -R qtum:qtum $QTUM_DATA \
	&& ln -sfn $QTUM_DATA /home/qtum/.qtum \
	&& chown -h qtum:qtum /home/qtum/.qtum
VOLUME /data

RUN apt-get install -y gosu
#https://stackoverflow.com/questions/38882654/docker-entrypoint-running-bash-script-gets-permission-denied/41571589#41571589
#you must have permission to run. If not then try: `chmod +x docker-entrypoint.sh`
COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8332 8333 18332 18333
CMD ["qtumd"]