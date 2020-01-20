FROM jetbrains/teamcity-agent

ENV DEBIAN_FRONTEND noninteractive

# Installing PHP
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    php-cli php-bz2 php-soap php-curl php-mbstring php-pdo \
    php-gd php-xml php-zip zip php-xdebug php-mysql
    
RUN apt-get install wget

RUN apt-get update && sudo apt-get dist-upgrade -y --no-install-recommends

CMD /run-services.sh
