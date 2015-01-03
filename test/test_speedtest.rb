require 'minitest/autorun'
require 'tmpdir'
require 'fileutils'
require_relative '../lib/speedtest/utils'

class TestUtils < MiniTest::Unit::TestCase
  def test_nbyte_string
    st=Speedtest::Utils.new

    string = st.nbyte_string(100)
    assert_equal string.length, 100

    string = st.nbyte_string(1, units=:KB)
    assert_equal string.length, 1_000

    string = st.nbyte_string(1, units=:MB)
    assert_equal string.length, 1_000_000

    assert_raises(RuntimeError) { st.nbyte_string(100, units=:FOO) }
    assert_raises(RuntimeError) { st.nbyte_string(100, units='MB') }

  end
  
end

class TestUtils < MiniTest::Unit::TestCase
  def xtest_aws_create_files
    st=Speedtest::Utils.new
    st.aws_create_files
  end

end