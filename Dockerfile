FROM jetbrains/teamcity-agent

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y --no-install-recommends install wget zip

RUN add-apt-repository -y ppa:ondrej/php

# Installing PHP7.4
RUN apt-get update && apt-get install -y --no-install-recommends php7.4

# Installing PHP Extensions
RUN apt-get install -y --no-install-recommends \
    php-cli php-bz2 php-soap php-curl php-pdo \
    php-gd php7.4-xml php-zip php-xdebug php-mysql

RUN apt-get update && sudo apt-get dist-upgrade -y --no-install-recommends

CMD /run-services.sh
