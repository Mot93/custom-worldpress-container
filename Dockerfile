FROM docker.io/wordpress:5.9

COPY custom.ini $PHP_INI_DIR/conf.d/