# FROM ruby:3.0.0-rc1-alpine3.12
FROM ruby:3.0.0-rc1-buster

# RUN apk add --update --no-cache linux-headers && \
  # rm -rf /tmp/* /var/cache/apk/*

WORKDIR /app

COPY Gemfile* ./
COPY .bundle/* .bundle/
RUN cp .bundle/config_production .bundle/config
RUN gem install nio4r -v '2.5.4'
RUN bundle
COPY . ./

EXPOSE 3000

CMD "./cmd.sh"
