module AppointmentsHelper
  require 'chronic'
  def convert_time(arr)
    arr.map! {|x| Time.at(x).utc.strftime("%I:%M %p") }
  end


end
