FROM nginx:1.19.3-alpine

ENV MODSECURITY_VERSION=v3.0.4
ENV MODSECURITY-NGINX-VERSION=v1.0.1
ENV OWASP_RULES_VERSION=v3.2.0

USER root
RUN apk add automake autoconf build-base libtool libxml2-dev linux-headers git pcre-dev wget zlib openssl && \
    cd opt && \
    wget https://github.com/SpiderLabs/ModSecurity/releases/download/${MODSECURITY_VERSION}/modsecurity-${MODSECURITY_VERSION}.tar.gz && \
    tar -xvzf modsecurity-${MODSECURITY_VERSION}.tar.gz && rm modsecurity-${MODSECURITY_VERSION}.tar.gz &&\
    cd modsecurity-${MODSECURITY_VERSION} && ./build.sh && \
    ./configure && make && make install && \
    cd /opt && wget https://github.com/SpiderLabs/ModSecurity-nginx/releases/download/v1.0.1/modsecurity-nginx-v1.0.1.tar.gz && \
    tar -xvzf modsecurity-nginx-v1.0.1.tar.gz && rm modsecurity-nginx-v1.0.1.tar.gz


RUN cd /opt && \
    version="$(nginx -v 2<&1| cut -d '/' -f2)" && \
    wget http://nginx.org/download/nginx-${version}.tar.gz && \
    tar -xvzf nginx-${version}.tar.gz && rm nginx-${version}.tar.gz && \
    cd nginx-${version} && \
    ./configure --with-compat --add-dynamic-module=/opt/modsecurity-nginx-v1.0.1 && \
    make modules && \
    cp objs/ngx_http_modsecurity_module.so /etc/nginx/modules/

RUN mkdir -p /etc/modsecurity.d && \
   cd /etc/modsecurity.d && \
   wget https://github.com/SpiderLabs/owasp-modsecurity-crs/archive/${OWASP_RULES_VERSION}.tar.gz && \
   tar -xvzf ${OWASP_RULES_VERSION}.tar.gz && \
   mv owasp-modsecurity-crs-3.2.0/ crs/

COPY docker/setup.conf /etc/modsecurity.d/setup.conf
COPY docker/configs/* /etc/nginx/conf.d/
COPY docker/nginx.conf /etc/nginx/

CMD ["nginx", "-g", "daemon off;"]