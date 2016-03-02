FROM shanesveller/elixir-lang:1.2.3

MAINTAINER Shane Sveller <shane@shanesveller.com>

RUN apk-install nodejs postgresql-client
RUN npm install -g npm

ONBUILD WORKDIR /usr/src/app

ONBUILD COPY *.js* /usr/src/app/
ONBUILD RUN npm install

ONBUILD ENV MIX_ENV prod
ONBUILD COPY mix.* /usr/src/app/
ONBUILD COPY config /usr/src/app/
ONBUILD RUN mix do deps.get --only prod, deps.compile
