require 'aws-sdk'
module Speedtest
  class Utils
    def initialize
      @file_tmpl = "bytes_%s%s.txt"
      @bucket = 'rrosen326.speedtest'
    end

    # Create a file of size bytes (units in ['KB', 'MB', nil (1)])
    #
    # Note - this uses decimal vales for KB/MB.  So 1 MB will be 10^6 bytes, but
    #  will show up as 977K on the file system. (See http://en.wikipedia.org/wiki/Megabyte)
    def create_file(size, path, overwrite=false, units=nil)
      raise 'Improper value for units. Must be MB, KB, or nil(1) ' if units and not %w(KB MB).include? units.to_s.upcase

      if not overwrite and  File.exists?(path)
        raise "File (#{path}) already exists and overwrite flag set to false."
      end

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

    def aws_create_files
      s3_rw_creds = Aws::Credentials.new(*(ENV['aws_s3_rw'].split(',')))
      s3 = Aws::S3::Client.new(region: 'us-west-2', credentials: s3_rw_creds )

      [[100,nil], [1,'KB'], [1, 'MB']].each do |size, units|

        puts("Writing to aws: size: #{size}  units: #{units}")
        fname = sprintf @file_tmpl, size, units
        create_file(size, fname, overwrite=true,units=units)
        body=File.open(fname) {|f| f.read}
        s3.put_object(bucket: @bucket, key: fname, body: body )
      end
    end
  end
end



