require 'aws-sdk'
module Speedtest
  class Utils
    def initialize
      @file_tmpl = 'bytes_%s%s.txt'
      @bucket = 'rrosen326.speedtest'
      @units = {
        :ONE => 1,
        :KB => 1_000,
        :MB => 1_000_000
      }
    end

    # Create a file of size bytes (units in [:KB, :MB, nil/:ONE (1)])
    #
    # Note - this uses decimal vales for KB/MB.  So 1 MB will be 10^6 bytes, but
    #  will show up as 977K on the file system. (See http://en.wikipedia.org/wiki/Megabyte)
    def nbyte_string(size, units=:ONE)
      units ||= :ONE

      raise "Improper units.  Must be in: #{@units.keys}.  Got: #{units}" if not @units.key? units

      return '0' * size * @units[units]
    end

    def aws_create_files
      s3_rw_creds = Aws::Credentials.new(*(ENV['aws_s3_rw'].split(',')))
      s3 = Aws::S3::Client.new(region: 'us-west-2', credentials: s3_rw_creds )

      [[100,:ONE], [1, :KB], [1, :MB]].each do |size, units|

        puts("Writing to aws: size: #{size}  units: #{units}")
        fname = sprintf @file_tmpl, size, units
        body = nbyte_string(size, units=units)
        s3.put_object(bucket: @bucket, key: fname, body: body )
      end
    end
  end
end



