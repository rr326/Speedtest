require 'minitest/autorun'
require 'aws-sdk'
require_relative '../lib/speedtest/utils'

# This isn't really a test - its an easy way to run the create file task.
# TODO: Move to Rake
class TestUtils < MiniTest::Test
  include Speedtest

  def test_aws_create_files
    Utils.create_files
  end

  def test_aws_get_files
    assert_equal  1, Utils.get_file(1, :ONE).length
    assert_equal  1024, Utils.get_file(1, :KB).length
    assert_equal  1024*1024, Utils.get_file(1, :MB).length

    assert_raises(Aws::S3::Errors::NoSuchKey) { Utils.get_file(23, units=:ONE) }
  end
end

class TestUtils < MiniTest::Test
  include Speedtest

  def test_timer
    time, retval = Utils.timer do
      sleep 1.35
      'success!'
    end
    assert_equal retval, 'success!'
    assert_equal time.round(2), 1.35
  end
end

