require_relative 'utils'
require 'logging'



module Speedtest
  class Measure
    def initialize
      Logging.logger.root.level = :debug
      Logging.logger.root.appenders = Logging.appenders.stdout
      @log = Logging.logger['main_log']
    end

    # Measure latency by timing the retrieval of a 1 byte file
    def latency
      t, e = _time_get_file(1, :ONE)
      res = TimerResult.new('latency', t, e)
    end

    # Measure throughput by timing the retrieval of a big file
    def throughput
      qty = 10
      units = :MB
      t, e =_time_get_file(qty, units)
      res = TimerResult.new('throughput', t, e, qty, units)
    end

    class TimerResult
      attr_reader :error, :duration, :speed
      def initialize(measure, duration, error, qty=nil, units=nil)
        @measure = measure
        @time = Time.now
        @duration = duration
        @error = error
        @speed =  qty ? (Utils::UNITS[units] * qty) / @duration : nil
      end
class ::Float
  def comma(prec=0)
    self.round(prec).to_s.reverse.gsub(/...(?=.)/,'\&,').reverse
  end
end
      

      def to_log
        sprintf "%s\t%s\t%ss\t%sb/s\t%s", @time, @measure, @duration, @speed ? @speed.comma : '--' || 0, @error
      end

      def to_s
        to_log
      end

      def error?
        !@error.nil?
      end
    end

    def _time_get_file(size, units)
      time, errval = Utils.timer do
        begin
          Utils.get_file(size, units)
        rescue IOError => e
          @log.info e.to_s
          err = {errno: -1, err: e}
        rescue Exception => e
          @log.error "Unhandled exception: #{e}"
          err = {errno: -2, err: e}
        else
          err = nil
        end
        err
      end
      return time, errval
    end

  end
end

