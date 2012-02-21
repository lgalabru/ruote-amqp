
Gem::Specification.new do |s|

  s.name = 'ruote-amqp'

  s.version = File.read(
    File.expand_path('../lib/ruote-amqp/version.rb', __FILE__)
  ).match(/ VERSION *= *['"]([^'"]+)/)[1]

  s.platform = Gem::Platform::RUBY
  s.authors = [ 'Kenneth Kalmer', 'John Mettraux' ]
  s.email = [ 'kenneth.kalmer@gmail.com', 'jmettraux@gmail.com' ]
  s.homepage = 'http://ruote.rubyforge.org'
  s.rubyforge_project = 'ruote'
  s.summary = 'AMQP participant/listener pair for ruote'
  s.description = %{
AMQP participant/listener pair for ruote
  }

  #s.files = `git ls-files`.split("\n")
  s.files = Dir[
    'Rakefile',
    'lib/**/*.rb', 'spec/**/*.rb', 'test/**/*.rb',
    '*.gemspec', '*.txt', '*.rdoc', '*.md'
  ]

  s.add_runtime_dependency 'amqp', '~> 0.9'
  s.add_runtime_dependency 'ruote', '>= 2.2.1'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 2.8'

  s.require_path = 'lib'
end

