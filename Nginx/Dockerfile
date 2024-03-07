FROM alpine:3.19.1 AS builder

# https://github.com/nginx/nginx
ADD ./nginx-1.21.1/ /opt/nginx-1.21.1
# https://github.com/chobits/ngx_http_proxy_connect_module
ADD ./ngx_http_proxy_connect_module-0.0.5 /opt/ngx_http_proxy_connect_module-0.0.5

RUN apk --no-cache add \
    build-base \
    openssl-dev \
    pcre-dev \
    zlib-dev


RUN cd /opt/nginx-1.21.1 && ./configure --prefix=/usr/local/nginx && make && make install && \
    patch -p1 < /opt/ngx_http_proxy_connect_module-0.0.5/patch/proxy_connect_rewrite_102101.patch && \
    ./configure --add-module=/opt/ngx_http_proxy_connect_module-0.0.5 && \
    make && make install



FROM alpine:3.19.1

COPY --from=builder /usr/local/nginx /usr/local/nginx

RUN apk --no-cache add \
    openssl \
    pcre \
    zlib

COPY nginx.conf /usr/local/nginx/conf/nginx.conf
WORKDIR /usr/local/nginx

EXPOSE 80
EXPOSE 443

CMD ["sbin/nginx", "-g", "daemon off;"]
