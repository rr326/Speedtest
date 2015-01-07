require 'rake/testtask'

# Rake::TestTask.new do |t|
#   t.name = :
#   t.pattern = "test/test_speedtest.rb"
# end

# Rake::TestTask.new do |t|
#   t.name = 'long'
#   t.pattern = "test/test_longrunning.rb"
# end

# Rake::TestTask.new do |t|
#   t.name = 'test'
#   t.pattern = "test/test_speedtest.rb"
# end

puts 'In Rakefile!'

t = Rake::TestTask.new('test:long')
t.pattern = 'test/test_longrunning.rb'

t = Rake::TestTask.new('test:all')
t.pattern = 'test/**/*.rb'

wip = Rake::TestTask.new('test:wip')
wip.pattern = 'test/test_speedtest.rb'

task :test => ["test:all"]

puts 'Leaving Rakefile!'
