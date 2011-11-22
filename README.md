PostBin
=======

PostBin, a simple web service for testing WebHooks (HTTP POST requests).

Quick Start
-----------

    $ gem install postbin
    $ postbin
    == Starting PostBin on http://127.0.0.1:6969
    == Sinatra/1.3.1 has taken the stage on 6969 for development with backup from Thin
    >> Thin web server (v1.2.11 codename Bat-Shit Crazy)
    >> Maximum connections set to 1024
    >> Listening on 127.0.0.1:6969, CTRL+C to stop

When running postbin from the command line, requests are stored in a temporary
file database, they will be lost once the server terminates.

Rack Application
----------------

You can run a more permeant install by running PostBin as a Rack application:

    # example config.ru
    require 'postbin'
    # path of pstore file to use for storage.
    pstore = File.expand_path(File.join(File.dirname(__FILE__), 'postbin.pstore'))
    # start the server.
    run PostBin::Server.new(pstore)

Command Line Options
--------------------

    Usage: postbin [options]

    PostBin options:
      -v, --version            show version number
      -h, --help               show this message

    Rack options:
      -s, --server SERVER      server (webrick, mongrel, thin, etc.)
      -a, --address HOST       listen on HOST address (default: 127.0.0.1)
      -p, --port PORT          use PORT number (default: 6969)
