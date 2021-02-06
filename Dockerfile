FROM ruby:2

WORKDIR /usr/src

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . ..

EXPOSE 4000
