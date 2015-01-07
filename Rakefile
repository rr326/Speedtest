require 'rake/testtask'
require_relative 'lib/speedtest/utils'


t = Rake::TestTask.new('test:long')
t.pattern = 'test/test_longrunning.rb'

t = Rake::TestTask.new('test:all')
t.pattern = 'test/**/*.rb'

wip = Rake::TestTask.new('test:wip')
wip.pattern = 'test/test_speedtest.rb'

task :test => ["test:all"]

task :buildfiles do |t|
  Speedtest::Utils.create_files
end