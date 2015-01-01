require 'minitest/autorun'
require 'tmpdir'
require 'fileutils'
require_relative '../lib/speedtest/utils'

class TestUtils < MiniTest::Unit::TestCase
  def setup
    @dir = Dir.mktmpdir
  end

  def test_create_file
    file = "#{@dir}/test1.txt"
    puts file
    st=Speedtest::Utils.new
    ftext=''


    File.open(file, 'w') do |f|
      assert_raises(RuntimeError) { st.create_file(100, file, false) }
    end

    st.create_file(100, file, true)
    File.open(file) {|f| ftext=f.read}
    puts "ftext[0...30]\n#{ftext[0...30]}"
    assert_equal ftext.length, 100

    assert_raises(RuntimeError) { st.create_file(100, file, true, units='Foo') }
    
    st.create_file(1, file, true, units='kb')
    File.open(file) {|f| ftext=f.read}
    assert_equal ftext.length, 1_000

    st.create_file(1, file, true, units='Mb')
    File.open(file) {|f| ftext=f.read}
    assert_equal ftext.length, 1_000_000
  end

  def teardown
    FileUtils.remove_entry(@dir, force = true)
  end
end
