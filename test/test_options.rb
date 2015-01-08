require 'minitest/autorun'
require_relative '../lib/speedtest/options'


class TestUtils < MiniTest::Test
  def test_options
    opts = Speedtest::Options.new.parse([''])
    Speedtest::Options.display_help_if_needed(opts)
    out, err = capture_io do
      Speedtest::Options.display_help_if_needed(opts)
    end
    assert_match /Usage/, out, 'Should display help'

    out, err = capture_io do
      opts = Speedtest::Options.new.parse(['--unknown'])
    end    
    assert_match /Unknown options/, out, 'Should display unknown option'

    opts = Speedtest::Options.new.parse(['-l', '-t'])
    assert opts[:latency]
    assert opts[:throughput]
  end
end