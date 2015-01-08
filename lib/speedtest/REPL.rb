# require_relative 'utils'
# require 'pry'

# binding.pry
# Speedtest::Utils.test_force_timeout(true)
# Speedtest::Utils.get_file 1, :MB
# Speedtest::Utils.test_force_timeout(oldval)

class C
  def initialize
    @var = 'initial'
  end
  
  def var
    @var
  end

  def var=(val)
    @var=val
  end


end

c=C.new
puts c.var
c.var = 'Updated'
puts c.var
