FROM ubuntu:14.04
MAINTAINER jaroslawnyka@gmail.com

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y --fix-missing \
autoconf            \
automake            \
apt-utils           \
bison               \
build-essential     \
curl                \
devscripts          \
dh-autoreconf       \
doxygen             \
flex                \
g++                 \
git-core            \
libtool             \
make                \
pkg-config          \
tree                \
apache2-dev         \
libcurl4-gnutls-dev \
libgeoip-dev        \
liblmdb-dev         \
libpcre++-dev       \
libxml2-dev         \
libyajl-dev         \
wget                \
lsof                \
vim                 \
zlib1g-dev

#make modsecurity
RUN git clone https://github.com/SpiderLabs/ModSecurity
RUN cd /ModSecurity && git checkout v3/master && git submodule init && git submodule update && ./build.sh && ./configure --without-lmdb && make && make install

RUN git clone https://github.com/SpiderLabs/ModSecurity-nginx

#make nginx
RUN wget http://nginx.org/download/nginx-1.12.0.tar.gz
RUN tar xvzf nginx-1.12.0.tar.gz && cd /nginx-1.12.0 && ./configure \
--user=root \
--group=root \
--with-debug \
--with-http_ssl_module \
--with-http_ssl_module \
--without-http_access_module \
--without-http_auth_basic_module \
--without-http_autoindex_module \
--without-http_empty_gif_module \
--without-http_fastcgi_module \
--without-http_referer_module \
--without-http_memcached_module \
--without-http_scgi_module \
--without-http_split_clients_module \
--without-http_ssi_module \
--without-http_uwsgi_module \
--add-module=/ModSecurity-nginx \
&& make && make install

#configure env
RUN ln -s /usr/local/nginx/sbin/nginx /bin/nginx
RUN mkdir -p /opt/modsecurity/var/audit/

#install signature
RUN git clone https://github.com/SpiderLabs/owasp-modsecurity-crs.git /usr/src/owasp-modsecurity-crs
RUN cp -R /usr/src/owasp-modsecurity-crs/rules/ /usr/local/nginx/conf/
RUN mv /usr/local/nginx/conf/rules/REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf.example /usr/local/nginx/conf/rules/REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf
RUN mv /usr/local/nginx/conf/rules/RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf.example /usr/local/nginx/conf/rules/RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf

RUN apt-get purge -y build-essential wget git
RUN rm /nginx-1.12.0.tar.gz

ADD nginx.conf /usr/local/nginx/conf/nginx.conf
ADD modsec_includes.conf /usr/local/nginx/conf/modsec_includes.conf
ADD modsecurity.conf /usr/local/nginx/conf/modsecurity.conf
ADD crs-setup.conf /usr/local/nginx/conf/rules/crs-setup.conf

CMD nginx -g 'daemon off;'

EXPOSE 80
