FROM ruby:2

WORKDIR /usr/src/docs

COPY docs/Gemfile docs/Gemfile.lock ./
RUN bundle install

COPY . ..

EXPOSE 4000
