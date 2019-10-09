FROM jetbrains/teamcity-agent

# Installing PHP
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    php-cli php-bz2 php-soap php-curl php-mbstring php-pdo \
    php-gd php-xml php-zip zip php-xdebug php-mysql && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN DEBIAN_FRONTEND=noninteractive apt-get update && sudo apt-get dist-upgrade -y --no-install-recommends

# Installing and start mysql
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends mysql-server && \
    usermod -d /var/lib/mysql/ mysql && \
    service mysql start && \
    update-rc.d mysql defaults

CMD echo "Started." | wc -
