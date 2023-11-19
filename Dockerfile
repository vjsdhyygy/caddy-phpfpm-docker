FROM caddy:alpine AS caddy-deps

FROM alpine:3.18

LABEL maintainer="vjsdhyygy <chaowencn@gmail.com>"

RUN apk update && \
	apk add  \
		ca-certificates \
		mailcap \
		supervisor \
		libcap \
		php81 \
		php81-bcmath \
		php81-brotli \
		php81-bz2 \
		php81-calendar \
		php81-common \
		php81-ctype \
		php81-curl \
		php81-dba \
		php81-dbg \
		php81-dev \
		php81-doc \
		php81-dom \
		php81-embed \
		php81-enchant \
		php81-exif \
		php81-ffi \
		php81-fileinfo \
		php81-fpm \
		php81-ftp \
		php81-gd \
		php81-gettext \
		php81-gmp \
		php81-iconv \
		php81-imap \
		php81-intl \
		php81-ldap \
		php81-litespeed \
		php81-mbstring \
		php81-mysqli \
		php81-mysqlnd \
		php81-odbc \
		php81-opcache \
		php81-openssl \
		php81-pcntl \
		php81-pdo \
		php81-pdo_dblib \
		php81-pdo_mysql \
		php81-pdo_odbc \
		php81-pdo_pgsql \
		php81-pdo_sqlite \
		php81-pear \
		php81-pecl-amqp \
		php81-pecl-apcu \
		php81-pecl-ast \
		php81-pecl-couchbase \
		php81-pecl-igbinary \
		php81-pecl-imagick \
		php81-pecl-imagick-dev \
		php81-pecl-lzf \
		php81-pecl-maxminddb \
		php81-pecl-memcache \
		php81-pecl-memcached \
		php81-pecl-mongodb \
		php81-pecl-msgpack \
		php81-pecl-protobuf \
		php81-pecl-psr \
		php81-pecl-redis \
		php81-pecl-smbclient \
		php81-pecl-ssh2 \
		php81-pecl-swoole \
		php81-pecl-swoole-dev \
		php81-pecl-uploadprogress \
		php81-pecl-uploadprogress-doc \
		php81-pecl-uuid \
		php81-pecl-xdebug \
		php81-pecl-xhprof \
		php81-pecl-xhprof-assets \
		php81-pecl-yaml \
		php81-pecl-zstd \
		php81-pgsql \
		php81-phar \
		php81-phpdbg \
		php81-posix \
		php81-pspell \
		php81-session \
		php81-shmop \
		php81-simplexml \
		php81-snmp \
		php81-soap \
		php81-sockets \
		php81-sodium \
		php81-sqlite3 \
		php81-sysvmsg \
		php81-sysvsem \
		php81-sysvshm \
		php81-tidy \
		php81-tokenizer \
		php81-xml \
		php81-xmlreader \
		php81-xmlwriter \
		php81-xsl \
		php81-zip 

RUN set -eux; \
	mkdir -p \
		/config/caddy \
		/data/caddy \
		/etc/caddy \
		/usr/share/caddy \
	; \
	wget -O /usr/share/caddy/index.html "https://github.com/caddyserver/dist/raw/0c7fa00a87c65a6ef47ed36d841cd223682a2a2c/welcome/index.html"


ENV XDG_CONFIG_HOME /config
ENV XDG_DATA_HOME /data


LABEL org.opencontainers.image.version="caddy v2.7.5 and php8.1-fpm "
LABEL org.opencontainers.image.title="Caddy whit php81-fpm"
LABEL org.opencontainers.image.description="apk add php-fpm"
LABEL org.opencontainers.image.documentation=https://caddyserver.com/docs
LABEL org.opencontainers.image.vendor="vjsdhyygy"
LABEL org.opencontainers.image.licenses=Apache-2.0
LABEL org.opencontainers.image.source="https://github.com/vjsdhyygy/caddy-phpfpm-docker"
		

EXPOSE 80
EXPOSE 443
EXPOSE 443/udp
EXPOSE 2019

WORKDIR /srv
COPY --from=caddy-deps /usr/bin/caddy /usr/bin/caddy
COPY ./etc/supervisord.conf /etc/
COPY ./etc/supervisord /etc/supervisord/
COPY ./info.php /usr/share/caddy/info.php
COPY ./Caddyfile /etc/caddy/Caddyfile
CMD ["supervisord","-n","-c","/etc/supervisord.conf"]

