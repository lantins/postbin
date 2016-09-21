FROM ruby:2

EXPOSE 80

RUN gem install thin postbin

CMD ["postbin", "--address", "0.0.0.0", "--port", "80"]

