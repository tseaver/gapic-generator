FROM ruby:2.5

RUN mkdir /app

WORKDIR /app

COPY . /app

RUN ls

RUN git init

RUN bundle install

EXPOSE 8080

CMD bundle exec rake test
