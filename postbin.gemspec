require './lib/postbin/version'

spec = Gem::Specification.new do |s|
  s.name                = 'postbin'
  s.version             = PostBin::Version
  s.licenses            = 'MIT'
  s.date                = Time.now.strftime('%Y-%m-%d')
  s.summary             = 'PostBin, a simple web service for testing WebHooks (HTTP POST requests).'
  s.homepage            = 'https://github.com/lantins/postbin'
  s.authors             = ['Luke Antins']
  s.email               = ['luke@lividpenguin.com']

  s.files               = %w(Rakefile README.md HISTORY.md Gemfile postbin.gemspec)
  s.files              += Dir.glob('{test/**/*,lib/**/*}')
  s.require_paths       = ['lib']
  s.executables         = ['postbin']

  s.add_dependency('sinatra', '~> 2.0')
  s.add_dependency('multi_json', '~> 1.0')
  s.add_dependency('json', '~> 2.0')
  s.add_dependency('thin', '~> 1')
  s.add_development_dependency('rake', '~> 13.0')
  s.add_development_dependency('yard', '~> 0.9')
  s.add_development_dependency('minitest', '~> 5.14')
  s.add_development_dependency('rack-test', '~> 1.1')
  s.add_development_dependency('bundler', '~> 2.1')
  s.add_development_dependency('rubygems-tasks', '~> 0.2')

  s.description       = <<-EOL
  A ruby command line/rack application for testing systems that send WebHooks
  using a HTTP POST request. Requests can be viewed via a simple web interface.
  EOL
end
