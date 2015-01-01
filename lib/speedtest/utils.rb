
module Speedtest
  class Utils
    def initialize

    end

    def create_file(size, path, overwrite=false, units=nil)
      raise 'Improper value for units. Must be MB, KB, or nil(1) ' if units and not ['MB', 'KB'].include? units.to_s.upcase

      if not overwrite and  File.exists?(path)
        raise "File (#{path}) already exists and overwrite flag set to false."
      end

      # There is ambiguity on if a MB is 1,000,000 bytes, or 1024 KB.
      # Im using 10^6 - per wikipedia
      case units.to_s.upcase
        when 'KB'
          size *= 1_000
        when 'MB'
          size *= 1_000_000
      end

      File.open(path, 'w', 0644) do |f|
        (1..size).each do |i|
          f.print "#{i % 10}"
        end
      end
      return path
    end
  end
end



