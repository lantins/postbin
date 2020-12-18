# Build a local docker image using `rake`:
#
#   rake docker-image
#
# Example for running a container using youre new image:
#
#   docker run -it --rm --publish 0.0.0.0:6969:6969 postbin:latest
#

FROM ruby:2
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN gem install postbin

EXPOSE 6969/tcp
CMD ["postbin", "--address", "0.0.0.0", "--port", "6969"]
