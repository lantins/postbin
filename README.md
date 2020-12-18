# PostBin

PostBin, a simple web service for testing and logging of the receival of WebHooks
(HTTP POST requests).

## Quick Start: Stand Alone

```shell
$ gem install postbin
$ postbin
== Starting PostBin on http://127.0.0.1:6969
== Sinatra/1.3.1 has taken the stage on 6969 for development with backup from Thin
>> Thin web server (v1.2.11 codename Bat-Shit Crazy)
>> Maximum connections set to 1024
>> Listening on 127.0.0.1:6969, CTRL+C to stop
```

When running postbin from the command line, requests are stored in a temporary
file database, they will be lost once the server terminates.

You can then submit a basic POST request using `curl` as follows:

```shell
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"foo":"bar", "hello":"world", "number": 42}' \
  http://127.0.0.1:6969/my/fake/path
```

Rar

## Quick Start: Rack Application

You can run a more permeant install by running PostBin as a Rack application:

```ruby
# example config.ru
require 'postbin'

# path of pstore file to use for storage.
pstore = File.expand_path(File.join(File.dirname(__FILE__), 'postbin.pstore'))

# start the server.
PostBin::Server.set :pstore_file, pstore
run PostBin::Server.new(pstore)
```

## Command Line Options

```text
Usage: postbin [options]

PostBin options:
  -v, --version            show version number
  -h, --help               show this message

Rack options:
  -s, --server SERVER      server (webrick, mongrel, thin, etc.)
  -a, --address HOST       listen on HOST address (default: 127.0.0.1)
  -p, --port PORT          use PORT number (default: 6969)
```

---

## Quick Start: Local Development

Local development/testing is handled by `rake` tasks for the most part:

```shell
# list available `rake` task
rake -T
# build and install gem
rake install
```

If you wish to build/test a set of uncommited changes:

```shell
# build gem
gem build postbin.gemspec
# install gem (adjust as needed)
gem install postbin-<VERSION>.gem
```

## Release Instructions

1. Bump the version number found in `lib/postbin/version.rb`.
2. Tag git repo with the same version number.
3. Publush `.gem` to https://rubygems.org/:

```shell
# ensure tests pass first
rake test
# build a new gem
rake build
# release the new gem
rake release
```
