Gem::Specification.new do |s|
  s.name                  = 'speedtest'
  s.summary               = 'A simple tool to test the speed of your internet connection'
  s.description           = File.read(File.join(File.dirname(__FILE__), 'README.md'))
  s.requirements          = ['See README.md']
  s.version               = '0.0.1'
  s.author                = 'Ross Rosen'
  s.email                 = 'rrosen326@gmail.com'
  s.homepage              = 'http://rossrosen.me'
  s.platform              = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.1.5'
  s.files                 = Dir['**/**']
  s.executables           = ['speedtest']
  s.test_files            = Dir['test/**/*.rb']
  s.has_rdoc              = false
  s.licenses              = 'MIT'
end
