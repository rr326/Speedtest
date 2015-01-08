gem 'slop', '~>3.6.0'
require 'slop'

module Speedtest
  class Options
    def parse(argv=ARGV)
      opts = Slop.new({strict: true}) do \
        banner 'Usage: speedtest [options]'
        on 'h', 'help', 'help'
        on 'l', 'latency', 'latency'
        on 't', 'throughput', 'throughput'        
      end

      begin
        opts.parse(argv)
      rescue Slop::Error => e 
        puts e.message
        puts opts 
      end
      @opts = opts
      return opts
    end 

    def self.help_needed?(opts)
      opts[:help] or ! opts.to_hash.values.reduce do |v|
        v || nil
      end
    end    

    def self.display_help_if_needed(opts) 
      puts opts if help_needed?(opts)
    end  
  end
end
