FROM alpine:3.17

WORKDIR /home/deploy/apps/php7

RUN apk update
RUN apk add --no-cache nginx git gcc g++ make cmake pkgconf sqlite-dev libxml2-dev openssl-dev curl-dev oniguruma-dev

RUN wget https://www.php.net/distributions/php-8.2.0.tar.gz --directory-prefix /opt
RUN tar -xvf /opt/php-8.2.0.tar.gz --directory /opt

RUN cd /opt/php-8.2.0 && ./configure --prefix=/usr/local/php \
     --with-openssl \
    --with-curl \
    --with-zlib \
    --with-mysqli \
    --with-pdo-mysql \
    --enable-cli \
    --enable-fpm \
    --enable-xml \
    --enable-mbstring \
    && make \
    && make install

RUN  ln -s /usr/local/php/bin/php /usr/bin/php \
   && cd /opt \
   && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
   && php composer-setup.php --install-dir=/usr/bin --filename=composer

COPY app .
ADD docker/app.conf /etc/nginx/nginx.conf
ADD docker/entrypoint.sh /usr/local/entrypoint.sh
ADD docker/php-fpm.conf /usr/local/php/etc/php-fpm.conf
ADD docker/www.conf /usr/local/php/etc/php-fpm.d/www.conf

RUN chmod +x /usr/local/entrypoint.sh

ENTRYPOINT ["/usr/local/entrypoint.sh"]