FROM ubuntu-custom-wget-git

#make modsecurity
RUN cd /ModSecurity && git checkout v3/master && git submodule init && git submodule update && ./build.sh && ./configure --without-lmdb && make -j 8 && make install

