# Run me with:
#   $ watchr tests.watchr

# --------------------------------------------------
# Rules
# --------------------------------------------------

# lib files.
watch( '^lib/postbin.rb'                          )  { ruby tests }
watch( '^lib/postbin/(.*)\.rb'                    )  { |m| ruby "test/#{m[1]}_test.rb" }
# test files.
watch( '^test.*/.*_test\.rb'                        )  { |m| ruby m[0] }
watch( '^test/test_helper\.rb'                      )  { ruby tests }
# misc files.
watch( '^postbin\.gemspec'                        )  { ruby tests }
watch( '^Gemfile'                                   )  { ruby tests }

# --------------------------------------------------
# Signal Handling
# --------------------------------------------------
Signal.trap('QUIT') { ruby tests  } # Ctrl-\
Signal.trap('INT' ) { abort("\n") } # Ctrl-C

# --------------------------------------------------
# Helpers
# --------------------------------------------------
def ruby(*paths)
  run "bundle exec ruby #{gem_opt} -I.:lib:test -e'%w( #{paths.flatten.join(' ')} ).each { |p| require p }'"
end

def tests
  Dir['test/**/*_test.rb'] - ['test/test_helper.rb']
end

def run( cmd )
  puts   cmd
  system cmd
end

def gem_opt
  defined?(Gem) ? '-rubygems' : ''
end