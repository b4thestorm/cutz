module AppointmentsHelper
  require 'chronic'
  def convert_time(arr)
    arr.map! {|x| x.to_datetime.utc.strftime("%m/%d  %I:%M %P") }
  end

 
end
