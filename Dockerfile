FROM ruby:2.5.1
ENV LANG C.UTF-8
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs && apt-get install -y vim
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app
RUN mkdir -p tmp/sockets
VOLUME /app/public
VOLUME /app/tmp

# FROM ruby:2.5.3-alpine3.8

# ENV RUNTIME_PACKAGES="linux-headers libxml2-dev make gcc libc-dev nodejs tzdata mysql-client mysql-dev yarn vim" \
#     CHROME_PACKAGES="chromium-chromedriver zlib-dev chromium xvfb wait4ports xorg-server dbus ttf-freefont mesa-dri-swrast udev" \
#     BUILD_PACKAGES="build-base curl-dev" \
#     LANG=C.UTF-8 \
#     TZ=Asia/Tokyo

# RUN apk update && \
#     apk upgrade && \
#     apk add --no-cache ${RUNTIME_PACKAGES} && \
#     apk add --no-cache ${CHROME_PACKAGES} && \
#     apk add --virtual build-packages --no-cache ${BUILD_PACKAGES} && \
#     apk del build-packages

# RUN mkdir /app
# WORKDIR /app
# COPY Gemfile /app/Gemfile
# COPY Gemfile.lock /app/Gemfile.lock
# RUN bundle install
# COPY . /app
# RUN mkdir -p tmp/sockets
# VOLUME /app/public
# VOLUME /app/tmp