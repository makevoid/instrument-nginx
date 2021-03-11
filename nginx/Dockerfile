ARG ALPINE_VERSION=3.13
FROM alpine:$ALPINE_VERSION

ARG NGINX_VERSION=1.19.7

RUN apk --update add pcre libbz2 ca-certificates libressl && rm /var/cache/apk/*

RUN adduser -h /etc/nginx -D -s /bin/sh nginx
WORKDIR /tmp

ENV NGINX_VERSION=${NGINX_VERSION}

# add compilation env, build required C based gems and cleanup
RUN apk --update add --virtual build_deps build-base zlib-dev pcre-dev libressl-dev curl
RUN curl -fSL https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz -o nginx.tar.gz \
    && tar xzf nginx.tar.gz \
    && rm -f xzf nginx.tar.gz


COPY ngx_http_websocket_stat_module ./nginx-$NGINX_VERSION/ngx_http_websocket_stat_module


RUN cd nginx-$NGINX_VERSION && ./configure \
       --prefix=/usr/share/nginx \
       --sbin-path=/usr/sbin/nginx \
       --conf-path=/etc/nginx/nginx.conf \
       --error-log-path=stderr \
       --http-log-path=/dev/stdout \
       --pid-path=/var/run/nginx.pid \
       --lock-path=/var/run/nginx.lock \
       --http-client-body-temp-path=/var/cache/nginx/client_temp \
       --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
       --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
       --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
       --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
       --user=nginx \
       --group=nginx \
       --add-module=./ngx_http_websocket_stat_module \
       --with-http_addition_module \
       --with-http_auth_request_module \
       --with-http_gunzip_module \
       --with-http_gzip_static_module \
       --with-http_realip_module \
       --with-http_ssl_module \
       --with-http_stub_status_module \
       --with-http_sub_module \
       --with-http_v2_module \
       --with-threads \
       --with-stream \
       --with-stream_ssl_module \
       --with-stream_ssl_module \
       --without-http_memcached_module \
       --without-mail_pop3_module \
       --without-mail_imap_module \
       --without-mail_smtp_module \
       --with-pcre-jit \
       --with-cc-opt='-g -O2 -fstack-protector-strong -Wformat -Werror=format-security' \
       --with-ld-opt='-Wl,-z,relro -Wl,--as-needed' \
    && make install \
    && cd .. && rm -rf nginx-$NGINX_VERSION \
    && mkdir /var/cache/nginx \
    && rm /etc/nginx/*.default \
    && apk del build_deps && rm /var/cache/apk/*

COPY nginx.conf /etc/nginx/

VOLUME ["/var/cache/nginx"]
EXPOSE 80

CMD nginx -g 'daemon off;'
