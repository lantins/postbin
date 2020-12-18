require './lib/postbin/version'

spec = Gem::Specification.new do |s|
  s.name                = 'postbin'
  s.version             = PostBin::Version
  s.date                = Time.now.strftime('%Y-%m-%d')
  s.summary             = 'PostBin, a simple web service for testing WebHooks (HTTP POST requests).'
  s.homepage            = 'https://github.com/lantins/postbin'
  s.authors             = ['Luke Antins']
  s.email               = ['luke@lividpenguin.com']
  s.has_rdoc            = false

  s.files               = %w(Rakefile README.md HISTORY.md Gemfile postbin.gemspec)
  s.files              += Dir.glob('{test/**/*,lib/**/*}')
  s.require_paths       = ['lib']
  s.executables         = ['postbin']
  s.default_executable  = 'postbin'

  s.add_dependency('sinatra')
  s.add_dependency('multi_json')
  s.add_dependency('json')
  s.add_dependency('thin')
  s.add_development_dependency('rake')
  s.add_development_dependency('yard')
  s.add_development_dependency('minitest')
  s.add_development_dependency('rack-test')
  s.add_development_dependency('bundler')

  s.description       = <<-EOL
  A ruby command line/rack application for testing systems that send WebHooks
  using a HTTP POST request. Requests can be viewed via a simple web interface.
  EOL
end
