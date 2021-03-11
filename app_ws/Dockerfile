FROM ruby:3.0.0-rc1-alpine3.12
# FROM ruby:3.0.0-rc1-buster

RUN apk add --update --no-cache linux-headers g++ make && \
  rm -rf /tmp/* /var/cache/apk/*

WORKDIR /app

COPY Gemfile* ./
COPY .bundle/* .bundle/
RUN cp .bundle/config_production .bundle/config
RUN bundle
COPY . ./

EXPOSE 3001

CMD "./cmd.sh"
