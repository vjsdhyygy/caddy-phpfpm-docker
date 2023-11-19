FROM caddy:alpine AS caddy-deps

FROM alpine:3.16

LABEL maintainer="vjsdhyygy <chaowencn@gmail.com>"

RUN apk update && \
	apk add  \
		ca-certificates \
		mailcap \
		supervisor \
		libcap \
		php8 \
		php8-bcmath \
		php8-brotli \
		php8-bz2 \
		php8-calendar \
		php8-common \
		php8-ctype \
		php8-curl \
		php8-dba \
		php8-dbg \
		php8-dev \
		php8-doc \
		php8-dom \
		php8-embed \
		php8-enchant \
		php8-exif \
		php8-ffi \
		php8-fileinfo \
		php8-fpm \
		php8-ftp \
		php8-gd \
		php8-gettext \
		php8-gmp \
		php8-iconv \
		php8-imap \
		php8-intl \
		php8-ldap \
		php8-litespeed \
		php8-mbstring \
		php8-mysqli \
		php8-mysqlnd \
		php8-odbc \
		php8-opcache \
		php8-openssl \
		php8-pcntl \
		php8-pdo \
		php8-pdo_dblib \
		php8-pdo_mysql \
		php8-pdo_odbc \
		php8-pdo_pgsql \
		php8-pdo_sqlite \
		php8-pear \
		php8-pecl-amqp \
		php8-pecl-apcu \
		php8-pecl-ast \
		php8-pecl-couchbase \
		php8-pecl-igbinary \
		php8-pecl-imagick \
		php8-pecl-imagick-dev \
		php8-pecl-lzf \
		php8-pecl-maxminddb \
		php8-pecl-memcache \
		php8-pecl-memcached \
		php8-pecl-mongodb \
		php8-pecl-msgpack \
		php8-pecl-protobuf \
		php8-pecl-psr \
		php8-pecl-redis \
		php8-pecl-smbclient \
		php8-pecl-ssh2 \
		php8-pecl-swoole \
		php8-pecl-swoole-dev \
		php8-pecl-uploadprogress \
		php8-pecl-uploadprogress-doc \
		php8-pecl-uuid \
		php8-pecl-xdebug \
		php8-pecl-xhprof \
		php8-pecl-xhprof-assets \
		php8-pecl-yaml \
		php8-pecl-zstd \
		php8-pgsql \
		php8-phar \
		php8-phpdbg \
		php8-posix \
		php8-pspell \
		php8-session \
		php8-shmop \
		php8-simplexml \
		php8-snmp \
		php8-soap \
		php8-sockets \
		php8-sodium \
		php8-sqlite3 \
		php8-sysvmsg \
		php8-sysvsem \
		php8-sysvshm \
		php8-tidy \
		php8-tokenizer \
		php8-xml \
		php8-xmlreader \
		php8-xmlwriter \
		php8-xsl \
		php8-zip 

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


LABEL org.opencontainers.image.version="caddy  and php8-fpm "
LABEL org.opencontainers.image.title="Caddy whit php8-fpm"
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

