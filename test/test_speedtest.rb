require 'minitest/autorun'
require 'tmpdir'
require 'fileutils'
require_relative '../lib/speedtest/utils'
require_relative '../lib/speedtest/measure'

class TestUtils < MiniTest::Unit::TestCase
  def test_nbyte_string
    string = Speedtest::Utils::nbyte_string(100)
    assert_equal string.length, 100

    string = Speedtest::Utils::nbyte_string(1, units=:KB)
    assert_equal string.length, 1024

    string = Speedtest::Utils::nbyte_string(1, units=:MB)
    assert_equal string.length, 1024*1024

    assert_raises(RuntimeError) { Speedtest::Utils::nbyte_string(100, units=:FOO) }
    assert_raises(RuntimeError) { Speedtest::Utils::nbyte_string(100, units='MB') }

  end
  
end

class TestUtils < MiniTest::Unit::TestCase
  def xtest_aws_create_files
    Speedtest::Utils::aws_create_files
  end

end

class TestUtils < MiniTest::Unit::TestCase
  def test_measure
    st=Speedtest::Measure.new
    time, retval = st.latency
    assert_equal retval, 'success!'
    assert_equal time.round(2), 1.35
  end

end