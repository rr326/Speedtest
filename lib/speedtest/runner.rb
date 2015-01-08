require_relative 'options'
require_relative 'measure'

module Speedtest
  class Runner
    def initialize(argv=ARGV)      
      @opts = Speedtest::Options.new.parse(argv)      
    end

    def run

      Speedtest::Options.display_help_if_needed(@opts)

      if @opts[:latency] 
        res = Speedtest::Measure.new.latency
        puts res.to_log
      end

      if @opts[:throughput] 
        res = Speedtest::Measure.new.throughput
        puts res.to_log
      end

    end
  end
end