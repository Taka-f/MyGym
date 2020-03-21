FROM ruby:2.5.1
ENV LANG C.UTF-8
ARG RAILS_MASTER_KEY  
ENV RAILS_MASTER_KEY ${RAILS_MASTER_KEY}
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs chromium-driver && apt-get install -y vim
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app
RUN mkdir -p tmp/sockets
VOLUME /app/public
VOLUME /app/tmp
ARG RAILS_MASTER_KEY ENV RAILS_MASTER_KEY ${RAILS_MASTER_KEY}