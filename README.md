PostBin
=======

PostBin, a simple web service for testing WebHooks (HTTP POST requests).

Quick Start
-----------

    $ gem install postbin
    $ postbin
    == PostBin online http://127.0.0.1:6969/
    == CTRL+C to stop

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

    -a, --address HOST       listen on HOST address (default: 127.0.0.1)
    -p, --port PORT          use PORT number (default: 6969)
