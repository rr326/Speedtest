require 'minitest/autorun'
require 'aws-sdk'
require_relative '../lib/speedtest/utils'
require_relative '../lib/speedtest/measure'


class TestUtils < MiniTest::Test
  include Speedtest

  # def test_aws_create_files
  #   Utils.create_files
  # end

  def test_aws_get_files
    # TODO test timeout and other errors
    assert_equal  1, Utils.get_file(1, :ONE).length
    assert_equal  1024, Utils.get_file(1, :KB).length
    assert_equal  1024*1024, Utils.get_file(1, :MB).length

    assert_raises(Aws::S3::Errors::NoSuchKey) { Utils.get_file(23, units=:ONE) }
  end
end



class TestUtils < MiniTest::Test
  include Speedtest

  def test_latency
    m=Speedtest::Measure.new
    res = m.latency

    puts res.to_s
  end

  def test_throughput
    m=Speedtest::Measure.new
    res = m.throughput

    puts res.to_s
  end
end
