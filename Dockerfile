FROM shanesveller/elixir-lang:latest

MAINTAINER Shane Sveller <shane@shanesveller.com>

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update -q && \
    apt-get -y install apt-transport-https && \
    curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
    echo 'deb https://deb.nodesource.com/node_0.12 trusty main' > /etc/apt/sources.list.d/nodesource.list && \
    apt-get update -q && \
    apt-get -y install git inotify-tools nodejs=0.12.7-1nodesource1~trusty1 && \
    apt-get clean -y && \
    rm -rf /var/cache/apt/*

ONBUILD WORKDIR /usr/src/app

ONBUILD COPY *.js* /usr/src/app/
ONBUILD RUN npm install

ONBUILD ENV MIX_ENV prod
ONBUILD COPY mix.* /usr/src/app/
ONBUILD COPY config /usr/src/app/
ONBUILD RUN mix do deps.get, deps.compile


