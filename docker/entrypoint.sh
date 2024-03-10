#!/bin/sh
#Start the php fpm

/usr/local/php/sbin/php-fpm -R

/bin/sh -c "$@"