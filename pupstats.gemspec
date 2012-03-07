version = File.read("VERSION").strip

Gem::Specification.new do |s|
  s.name	= 'pupstats'
  s.version	= version
  s.platform    = Gem::Platform::RUBY
  s.summary	= "collect the puppet syslog information parse it and write to graphite"
  s.description	= "Put puppet stats into graphite"
  s.author	= "Chris Mague"
  s.homepage	= "http://blog.mague.com/"
  s.email	= "github@mague.com"
  s.files	=  Dir['README.md', 'VERSION', 'Gemfile', 'Rakefile', '{bin,lib,config,vendor}/**/*']
  s.executables = ['pupstats.rb']
  s.add_dependency('eventmachine', ['0.12.10'])
  s.add_dependency('log4r', ['1.1.9'])
  s.require_path = 'lib'
end
