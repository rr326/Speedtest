require_relative 'utils'

module Speedtest
  class Measure
    # Measure latency by timing the retrieval of a 1 byte file
    def latency
      time, retval = Utils::timer do
        sleep 1.35
        'success!'
      end
    end

    # Measure throughput by timing the retrieval of a big file
    def throughput

    end


  end
end