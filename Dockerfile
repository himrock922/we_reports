FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y locales

RUN locale-gen ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:jp
ENV LC_ALL ja_JP.UTF-8

ENV ELIXIR_VERSION 1.9.4

RUN apt install -y curl wget git make sudo tar bzip2 libfontconfig unzip build-essential inotify-tools
RUN wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
RUN dpkg -i erlang-solutions_1.0_all.deb
RUN apt update && apt install -y esl-erlang
RUN rm erlang-solutions_1.0_all.deb
RUN wget https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip
RUN mkdir -p /opt/elixir-${ELIXIR_VERSION}/ && unzip Precompiled.zip -d /opt/elixir-${ELIXIR_VERSION}/

RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -
RUN apt install -y nodejs

ENV PATH $PATH:/opt/elixir-${ELIXIR_VERSION}/bin

RUN mix local.hex --force
ADD mix.exs mix.exs
ADD mix.lock mix.lock
RUN mix deps.get

WORKDIR /usr/local/phoenix