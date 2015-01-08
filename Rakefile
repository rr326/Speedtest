require 'rake/testtask'
require_relative 'lib/speedtest/utils'


t = Rake::TestTask.new('test:long')
t.pattern = 'test/test_longrunning.rb'

t = Rake::TestTask.new('test:all')
t.pattern = 'test/**/*.rb'

wip = Rake::TestTask.new('test:wip')
wip.test_files = FileList.new('test/**/*.rb') do |fl|
  fl.exclude('test/test_longrunning.rb')
end
wip.pattern = nil

task :test => ["test:all"]

task :buildfiles do |t|
  Speedtest::Utils.create_files
end