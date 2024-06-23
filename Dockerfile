FROM nextcloud:fpm

RUN set -ex; \
apt-get update; \
apt-get install -y --no-install-recommends ffmpeg libx11-dev libopenblas-dev liblapack-dev git cmake;

WORKDIR /root


RUN git clone https://github.com/davisking/dlib.git; \
cd dlib/dlib; \
mkdir build; \
cd build; \
cmake -DBUILD_SHARED_LIBS=ON ..; \
make; \
make install;

RUN cd /root; \
rm -fr ./dlib;

RUN git clone https://github.com/goodspb/pdlib.git; \
cd pdlib; \
phpize; \
PKG_CONFIG_PATH=/usr/local/lib/pkgconfig ./configure --enable-debug; \
make; \
make install;

RUN cd /root; \
rm -fr ./pdlib;


RUN echo '[pdlib]\nextension="pdlib.so"' > /usr/local/etc/php/conf.d/pdlib.ini
