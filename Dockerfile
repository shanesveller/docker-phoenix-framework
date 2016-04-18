FROM shanesveller/elixir-lang:1.2.3

MAINTAINER Shane Sveller <shane@shanesveller.com>

RUN apk-install git nodejs postgresql-client
RUN npm install -g npm

ONBUILD WORKDIR /usr/src/app
ONBUILD ENV MIX_ENV prod

ONBUILD COPY mix.* /usr/src/app/
ONBUILD RUN mix do deps.get --only prod
ONBUILD COPY package.json /usr/src/app/
ONBUILD RUN npm install
ONBUILD RUN mix deps.compile --only prod

ONBUILD COPY config /usr/src/app/

ONBUILD COPY . /usr/src/app/
ONBUILD RUN mix compile
