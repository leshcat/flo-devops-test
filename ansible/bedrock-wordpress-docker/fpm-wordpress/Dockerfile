FROM php:7.3.4-fpm-alpine3.8

ENV DB_NAME=wordpress \
	DB_USER=root \
	DB_HOST=mariadb \
	WP_ENV=development

# taken from Wordpress offical fpm Dockerfile, for the most part
# https://github.com/docker-library/wordpress/blob/7d40c4237f01892bb6dbc67d1a82f5b15f807ca1/php7.0/fpm/Dockerfile
# install the PHP extensions we need
RUN apk --update --no-cache add less bash su-exec mysql-client freetype-dev libjpeg-turbo-dev libpng-dev \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd mysqli opcache

# install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
		php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
		php composer-setup.php && \
		php -r "unlink('composer-setup.php');"

RUN chmod +x composer.phar && mv composer.phar /usr/local/bin/composer

# install wordpress cli
# https://github.com/KaiHofstetter/docker-wordpress-cli/blob/master/Dockerfile
COPY wp.sh /usr/local/bin/wp
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && chmod +x /usr/local/bin/wp && \
    mv wp-cli.phar /usr/local/bin/wp-cli.phar

# taken from Wordpress offical fpm Dockerfile
# https://github.com/docker-library/wordpress/blob/7d40c4237f01892bb6dbc67d1a82f5b15f807ca1/php7.0/fpm/Dockerfile
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=2'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

# taken from mkz71's comment on Wordpress official Docker Hub page
# https://hub.docker.com/_/wordpress/
RUN { \
		echo 'file_uploads = On'; \
		echo 'memory_limit = 256M'; \
		echo 'upload_max_filesize = 256M'; \
		echo 'post_max_size = 300M'; \
		echo 'max_execution_time = 600'; \
	} > /usr/local/etc/php/conf.d/uploads.ini

# set folder permissions
RUN chown -R www-data:www-data . && chmod g+s .

RUN pwd

# install bedrock & set permissions
RUN su-exec www-data composer create-project roots/bedrock . && chmod -R 755 .

# init script and CMD
COPY init.sh /opt/
RUN chmod +x /opt/init.sh
CMD /opt/init.sh && exec php-fpm
