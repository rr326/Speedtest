require 'minitest/autorun'
require_relative '../lib/speedtest/utils'
require_relative '../lib/speedtest/measure'


class TestUtils < MiniTest::Test
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


class TestUtils < MiniTest::Test
  include Speedtest

  def test_timer
    time, retval = Utils.timer do
      sleep 0.05
      'success!'
    end
    assert_equal retval, 'success!'
    assert_equal time.round(2), 0.05
  end
end


class TestUtils < MiniTest::Test
  def test_measure
    # Test expected return
    Speedtest::Utils.stub :get_file, '0' do
      st=Speedtest::Measure.new
      res = st.latency
      assert !res.error?
      assert_in_delta 0.1, 0.1, res.duration
    end

    def raise_IO_Error(*args)
      raise IOError.new('Force expected error')
    end

    # Test handled failure
    Speedtest::Utils.stub :get_file, self.method(:raise_IO_Error) do
      st=Speedtest::Measure.new
      res = st.latency
      assert res.error?
      assert_equal -1, res.error[:errno]
    end

    def raise_other_Error(*args)
      raise RuntimeError.new('Force unexpected error')
    end

    # Test unexpected failure
    Speedtest::Utils.stub :get_file, self.method(:raise_other_Error) do
      st=Speedtest::Measure.new
      res = st.latency
      assert res.error?
      assert_equal -2, res.error[:errno]
    end

  end
end

