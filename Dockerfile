FROM caddy:alpine AS caddy-deps

FROM alpine:3.18

LABEL maintainer="vjsdhyygy <chaowencn@gmail.com>"

RUN apk update && \
	apk add  \
		ca-certificates \
		mailcap \
		supervisor \
		libcap \
		php82 \
		php82-bcmath \
		php82-brotli \
		php82-bz2 \
		php82-calendar \
		php82-common \
		php82-ctype \
		php82-curl \
		php82-dba \
		php82-dbg \
		php82-dev \
		php82-doc \
		php82-dom \
		php82-embed \
		php82-enchant \
		php82-exif \
		php82-ffi \
		php82-fileinfo \
		php82-fpm \
		php82-ftp \
		php82-gd \
		php82-gettext \
		php82-gmp \
		php82-iconv \
		php82-imap \
		php82-intl \
		php82-ldap \
		php82-litespeed \
		php82-mbstring \
		php82-mysqli \
		php82-mysqlnd \
		php82-odbc \
		php82-opcache \
		php82-openssl \
		php82-pcntl \
		php82-pdo \
		php82-pdo_dblib \
		php82-pdo_mysql \
		php82-pdo_odbc \
		php82-pdo_pgsql \
		php82-pdo_sqlite \
		php82-pear \
		php82-pecl-amqp \
		php82-pecl-apcu \
		php82-pecl-ast \
		php82-pecl-couchbase \
		php82-pecl-igbinary \
		php82-pecl-imagick \
		php82-pecl-imagick-dev \
		php82-pecl-lzf \
		php82-pecl-maxminddb \
		php82-pecl-memcache \
		php82-pecl-memcached \
		php82-pecl-mongodb \
		php82-pecl-msgpack \
		php82-pecl-protobuf \
		php82-pecl-psr \
		php82-pecl-redis \
		php82-pecl-smbclient \
		php82-pecl-ssh2 \
		php82-pecl-swoole \
		php82-pecl-swoole-dev \
		php82-pecl-uploadprogress \
		php82-pecl-uploadprogress-doc \
		php82-pecl-uuid \
		php82-pecl-xdebug \
		php82-pecl-xhprof \
		php82-pecl-xhprof-assets \
		php82-pecl-yaml \
		php82-pecl-zstd \
		php82-pgsql \
		php82-phar \
		php82-phpdbg \
		php82-posix \
		php82-pspell \
		php82-session \
		php82-shmop \
		php82-simplexml \
		php82-snmp \
		php82-soap \
		php82-sockets \
		php82-sodium \
		php82-sqlite3 \
		php82-sysvmsg \
		php82-sysvsem \
		php82-sysvshm \
		php82-tidy \
		php82-tokenizer \
		php82-xml \
		php82-xmlreader \
		php82-xmlwriter \
		php82-xsl \
		php82-zip 

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


LABEL org.opencontainers.image.version="caddy v2.7.5 and php8.2-fpm "
LABEL org.opencontainers.image.title="Caddy whit php82-fpm"
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

