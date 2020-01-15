# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','sherloc','version.rb'])
spec = Gem::Specification.new do |s|
  s.name = 'sherloc'
  s.version = Sherloc::VERSION
  s.author = 'Your Name Here'
  s.email = 'your@email.address.com'
  s.homepage = 'http://your.website.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A description of your project'
  s.files = `git ls-files`.split("
")
  s.require_paths << 'lib'
  s.bindir = 'bin'
  s.executables << 'sherloc'
  s.add_development_dependency('rake')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.19.0')
  s.add_runtime_dependency('rainbow','3.0.0')
  s.add_runtime_dependency('json','2.3.0')
end
