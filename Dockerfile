FROM jetbrains/teamcity-agent

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y --no-install-recommends install wget zip

RUN add-apt-repository -y ppa:ondrej/php

# Installing PHP7.4
RUN apt-get update && apt-get install -y --no-install-recommends php7.4

# Installing PHP Extensions
RUN apt-get install -y --no-install-recommends \
    php7.4-cli php7.4-bz2 php7.4-soap php7.4-curl php7.4-pdo \
    php7.4-gd php7.4-xml php7.4-zip php7.4-xdebug php7.4-mysql php7.4-mbstring

RUN apt-get update && sudo apt-get dist-upgrade -y --no-install-recommends

CMD /run-services.sh
