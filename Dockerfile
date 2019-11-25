FROM jetbrains/teamcity-agent

# Installing PHP
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    php-cli php-bz2 php-soap php-curl php-mbstring php-pdo \
    php-gd php-xml php-zip zip php-xdebug php-mysql && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN DEBIAN_FRONTEND=noninteractive apt-get update && sudo apt-get dist-upgrade -y --no-install-recommends

RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-cache build-essential libsqlite3-dev ruby-dev

# INSTALL MAILCATCHER
#https://gist.github.com/shark0der/28f55884a876f67c92ce
# Make it start on boot
RUN echo "@reboot root $(which mailcatcher) --ip=0.0.0.0" >> /etc/crontab
RUN update-rc.d cron defaults

RUN gem install mailcatcher --no-ri --no-rdoc

# Make php use it to send mail
RUN echo "sendmail_path = /usr/bin/env $(which catchmail) -f 'www-data@localhost'" >> /etc/php/7.2/mods-available/mailcatcher.ini

# Notify php mod manager (5.5+)
# older ubuntus
#php5enmod mailcatcher
# xenial
RUN phpenmod mailcatcher

# Start it now
RUN /usr/bin/env $(which mailcatcher) --ip=0.0.0.0

# INSTALL MAILCATCHER

# Installing and start mysql
RUN mkdir /var/lib/mysql
RUN mkdir /var/run/mysqld

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends mysql-server && \
    usermod -d /var/lib/mysql/ mysql && \
    update-rc.d mysql defaults

#Fix the mysql
RUN chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \
    service mysql start && \
    mvn -q verify site

CMD /run-services.sh


