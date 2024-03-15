FROM ruby:3.3.0
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN apt-get update && apt-get install -y cron
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle config set force_ruby_platform true
RUN bundle install
COPY . /myapp

CMD ["rails", "server", "-b", "0.0.0.0"]
