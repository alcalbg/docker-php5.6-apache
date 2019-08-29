# docker-php5.6-apache
Docker image with old php 5.6 running on apache2 with usual php extensions:

- php5.6
- php5.6-bcmath
- php5.6-mcrypt
- php5.6-mbstring
- php5.6-mysql
- php5.6-sqlite3
- php5.6-soap
- php5.6-xml
- php5.6-zip
- php5.6-xdebug

Based on Debian stretch

# sample usage
docker run -d -v /var/www/html:/var/www/html -p 8000:80 alcalbg/php5.6-apache
http://localhost:8000/

