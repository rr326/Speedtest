require 'minitest/autorun'
require 'aws-sdk'
require_relative '../lib/speedtest/utils'
require_relative '../lib/speedtest/measure'


class TestUtils < MiniTest::Test
  include Speedtest

  # def test_aws_create_files
  #   Utils.create_files
  # end

  # Test it gets all the files properly
  # Test that it raises IOError on timeout
  def test_get_file
    Utils::FILE_LIST.each do |size, units|
      assert_equal  size*Utils::UNITS[units], Utils.get_file(size, units).length

      oldval=Utils.test_force_timeout
      Utils.test_force_timeout = true
      assert_raises(IOError) { Utils.get_file(size, units) }
      Utils.test_force_timeout = oldval            
    end 

    assert_raises(Aws::S3::Errors::NoSuchKey) { Utils.get_file(23, :ONE) }
  end
end


class TestUtils < MiniTest::Test
  include Speedtest

  def test_latency
    m=Speedtest::Measure.new
    res = m.latency
    puts res
    assert_nil res.error
    assert res.duration
    
    oldval=Utils.test_force_timeout
    Utils.test_force_timeout = true
    res = m.latency
    puts "Forced timeout\n"
    puts res
    assert res.error
    Utils.test_force_timeout = oldval    
  end

  def test_throughput
    m=Speedtest::Measure.new
    res = m.throughput
    puts res
    assert_nil res.error
    assert res.duration
    assert res.speed
    
    oldval=Utils.test_force_timeout
    Utils.test_force_timeout = true
    res = m.throughput
    puts "Forced timeout\n"
    puts res
    assert res.error
    Utils.test_force_timeout = oldval    
  end
end
