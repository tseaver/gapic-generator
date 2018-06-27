FROM ruby:2.5

# Setup directory
RUN mkdir /showcase
WORKDIR /showcase
COPY . /showcase

# Init git since bundle install expects to be inside a repository.
RUN git init

# Install dependencies
RUN bundle install

# Default command
CMD bundle exec rake test
