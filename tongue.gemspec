Gem::Specification.new do |s|
  s.name    = 'tongue'
  s.version = '0.2.10.8'
  s.summary = "An Everyman's Linguist"

  s.authors  = "Geoff Nixon"
  s.homepage = "https://github.com/bathtub/tongue"

  s.files = Dir['lib/**/*']
  s.executables << 'tongue'
  s.required_ruby_version = '>= 1.9.3'
  s.add_dependency 'escape_utils',    '>= 0.3.2'
  s.add_dependency 'pygments.rb',     '~> 0.5.4'

  s.add_development_dependency 'json'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'yajl-ruby'
end
