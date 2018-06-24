FROM ruby:alpine
ADD . /code
WORKDIR /code
CMD ["ruby", "app.rb"]
