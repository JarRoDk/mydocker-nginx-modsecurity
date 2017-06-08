FROM ubuntu-custom

#make modsecurity
RUN cd /ModSecurity && git checkout v3/master && git submodule init && git submodule update && ./build.sh && ./configure --without-lmdb && make && make install

