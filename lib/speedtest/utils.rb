require 'aws-sdk'

module Speedtest
  class Utils
    @@file_tmpl = 'bytes_%s_%s.txt'
    @@bucket = 'rrosen326.speedtest'
    @@units = {
        :ONE => 1,
        :KB => 1024,
        :MB => 1024*1024
    }

    # Create a file of size bytes (units in [:KB, :MB, nil/:ONE (1)])
    #
    # Note - this uses binary vales for KB/MB (eg 1024=1KB).
    # This way if my speed says 1MB/s, it means i can transfer a 1MB file in 1 s
    # (File sizes use base 2).  This is how backblaze does it.
    # (See http://en.wikipedia.org/wiki/Megabyte &&  http://bit.ly/1vH9GM8)
    def self.nbyte_string(size, units=:ONE)
      units ||= :ONE

      raise "Improper units.  Must be in: #{@@units.keys}.  Got: #{units}" if not @@units.key? units

      return '0' * size * @@units[units]
    end

    # Return the time of a block:
    # [time(s), block_retval]
    def self.timer(&block)
      t0 = Time.now
      retval = block.call
      return [Time.now - t0, retval]
    end

    def self.aws_file_name(size, units)
      return sprintf @@file_tmpl, size, units
    end

    def self.create_files
      s3_rw_creds = Aws::Credentials.new(*(ENV['aws_s3_rw'].split(',')))
      s3 = Aws::S3::Client.new(region: 'us-west-2', credentials: s3_rw_creds)

      [[1,:ONE], [1, :KB], [1, :MB]].each do |size, units|

        puts("Writing to aws: size: #{size}  units: #{units}")
        fname = aws_file_name(size, units)
        body = nbyte_string(size, units=units)
        s3.put_object(bucket: @@bucket, key: fname, body: body )
      end
    end

    def self.get_file(size, units, extra_options={})
      s3_rw_creds = Aws::Credentials.new(*(ENV['aws_s3_r'].split(',')))
      s3 = Aws::S3::Client.new({region: 'us-west-2', credentials: s3_rw_creds}.merge(extra_options))
      fname = aws_file_name(size, units)
      begin
        resp = s3.get_object(bucket: @@bucket, key: fname)
      rescue Seahorse::Client::NetworkingError => e
        raise IOError.new "Failed to get file (#{fname}). Error: #{e}."
      end

      body = resp.body.read
      return body
    end
  end

end



