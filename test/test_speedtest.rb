require 'minitest/autorun'
require_relative '../lib/speedtest/utils'
require_relative '../lib/speedtest/measure'


class TestUtils < MiniTest::Unit::TestCase
  include Speedtest

  def test_nbyte_string
    string = Utils.nbyte_string(100)
    assert_equal string.length, 100

    string = Utils.nbyte_string(1, units=:KB)
    assert_equal string.length, 1024

    string = Utils.nbyte_string(1, units=:MB)
    assert_equal string.length, 1024*1024

    assert_raises(RuntimeError) { Utils.nbyte_string(100, units=:FOO) }
    assert_raises(RuntimeError) { Utils.nbyte_string(100, units='MB') }

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