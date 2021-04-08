require_relative 'lib/version'

Gem::Specification.new do |spec|
  spec.name          = 'todo-fede'
  spec.version       = Version::VERSION
  spec.authors       = ['Federico Moya']
  spec.email         = ['federicomoyamartin@gmail.com']
  spec.summary       = %q{ Cool todo app }
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')
  spec.files         = Dir['lib/**/*'] + Dir['bin/*']
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_development_dependency 'rubocop', '~> 0.79' 
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'byebug', '~> 11'
  spec.add_runtime_dependency 'thor', '~> 1.0.1'
end
