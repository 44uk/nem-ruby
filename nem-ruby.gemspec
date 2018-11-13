# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nem/version'

Gem::Specification.new do |spec|
  spec.name    = 'nem-ruby'
  spec.version = Nem::VERSION
  spec.authors = ['Yoshiyuki Ieyama']
  spec.email   = ['yukku0423@gmail.com']

  spec.summary     = 'Ruby gem for communicating with the nem'
  spec.description = 'Ruby gem for communicating with the nem'
  spec.homepage    = 'https://github.com/44uk/nem-ruby'
  spec.license     = 'MIT'

  spec.required_ruby_version = '>= 2.2.6'
  spec.metadata['yard.run'] = 'yri'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.post_install_message = '
  <# nem-ruby #>
  Please see https://gitter.im/44uk/nem-ruby for the latest information.
  The gem is under development. Incompatible changes can be made.
  Feel free to ask and give feedback to https://twitter.com/44uk_i3
  Good luck! NEM application development with Ruby!
  '

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'yard', '~> 0.9'
  spec.add_development_dependency 'rubocop', '~> 0.60'
  spec.add_development_dependency 'timecop', '~> 0.8'
  spec.add_development_dependency 'webmock', '~> 2.3'
  spec.add_development_dependency 'pry-byebug', '~> 3'

  spec.add_dependency 'digest-sha3', '~> 1.1'
  spec.add_dependency 'base32', '~> 0.3'
  spec.add_dependency 'faraday', '~> 0.11'
  spec.add_dependency 'faraday_middleware', '~> 0.11'
end
