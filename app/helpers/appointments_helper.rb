module AppointmentsHelper
  require 'chronic'
  def convert_time(arr)
    return arr.map! {|x| x.to_time.strftime("%I:%M") }
  end
end
