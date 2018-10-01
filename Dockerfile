FROM ubuntu:16.04

USER root

RUN apt-get update && \
    apt-get install -y git mysql-client libmysqlclient-dev libxslt1-dev libssl-dev \
            zlib1g-dev imagemagick libmagickcore-dev libmagickwand-dev openjdk-9-jre-headless libcairo2-dev \
            libjpeg8-dev libpango1.0-dev libgif-dev curl pdftk enscript libsqlite3-dev phantomjs build-essential redis-server rbenv npm && \
    curl -fsSL https://deb.nodesource.com/setup_6.x | sudo -E bash - && \
    apt-get install -y nodejs && \
    rbenv install 2.5.0 && \
    rbenv global 2.5.0 && \
    rbenv rehash && \
    curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && sudo apt-get install -y yarn=1.6.0-1

RUN git clone https://github.com/code-dot-org/code-dot-org.git && \
    gem install bundler && \
    rbenv rehash && \
    cd code-dot-org && \
    bundle install && \
    rake install:hooks && \
    rake install && \
    rake build
    
EXPOSE 8000


    
        
