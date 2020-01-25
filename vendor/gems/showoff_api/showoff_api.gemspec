# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'showoff_api'
  s.version     = '0.0.1'
  s.date        = '2020-01-25'
  s.summary     = 'Wrapper around the showoff API'
  s.description = 'Wrapper around the showoff API'
  s.authors     = ['Israel Tomilayo']
  s.email       = ['itomilayo@gmail.com']
  s.files       = ['lib/showoff_api.rb']
  s.license     = 'MIT'

  s.add_development_dependency 'rake', ['>= 0']
  s.add_development_dependency 'timecop', ['>= 0']

  s.add_runtime_dependency 'activesupport', ['>= 0']
  s.add_runtime_dependency 'openssl', ['>= 0']
  s.add_runtime_dependency 'rest-client', ['>= 0']
end
