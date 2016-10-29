# == Schema Information
#
# Table name: appointments
#
#  id           :integer          not null, primary key
#  schedule_day :datetime
#  schdule_time :datetime
#  barber_id    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  start_time   :datetime
#  end_time     :datetime
#  summary      :string
#  description  :string
#  location     :string
class Appointment < ActiveRecord::Base
require 'chronic'  
belongs_to :barber, class_name: 'User', foreign_key: :barber_id


# rails date: Thu, 23 Jun 2016 02:30:00 UTC +00:00
# google date: "2007-06-06T15:00:00.000Z"

 def fix_start_time
  time = Chronic.parse("#{self.start_time}")
  final = time.to_s.split(' ')
  result = "#{final[0]}T#{final[1]}z"
  result
 end 

 def fix_end_time
  time = Chronic.parse("#{self.end_time}")
  final = time.to_s.split(' ')
  result = "#{final[0]}T#{final[1]}z"
  result
 end
  
 #cpu heavy 
 #get the barbers availability for each day and generate free times based on that range
def get_barber(barber_id)
  @barber = User.where(id: barber_id).take
end

#generate a list of times
def generate_free_time(barber) 
    # t = Time.parse('Wed Dec 09 16:05:00 -0600 2009')
    # t + 15.minutes
   times = barber.barber_availability
   start_time = times[0].to_time
   arr = []
   until start_time > times[1].to_time
     arr.push(start_time.to_s) 
     start_time += 15.minutes
   end
   return arr
 end 
 
#last method before completing the Form object

# How to Remove the times: 
#grab the start and end time. check each value in the free time array 
#against the start and end range. Remove the free times that are within the
#range. Return the new free times array.

  #subtract_busy_time (free, busy) 
  def subtract_busy_time   
   list1 = free_times_to_integer(free)
   list2 = busy_times_to_integer
   beta_times = []
  
   list2.each do |x|
     list1.map do |y|  
      beta_times.push(y) if (x[0]..x[1]).cover?(y) == true
     end 
   end
   real_times = remove_times(list1, beta_times)
 #TODO: Parse Cronofy Busy Times into multidimensional array and pass into busy_times_to_integer
   # list1.select! do |x| 
   #  busy.start.time
   #  busy.end.time
   # end
  end

  def remove_times(list1, list2)
    list2.each do |x|
      list1.delete(x)
    end
    list1
  end
  
  def free_times_to_integer(*tstr)
   free_times = tstr.map! {|x| x.to_time.to_i} 
  end

  def busy_times_to_integer
   multi_busy = [["2016-10-29 13:00:00 UTC", "2016-10-29 13:30:00 UTC"],["2016-10-29 15:00:00 UTC", "2016-10-29 15:30:00 UTC"], 
    ["2016-10-29 16:00:00 UTC", "2016-10-29 16:30:00 UTC"], ["2016-10-29 17:00:00 UTC","2016-10-29 17:30:00 UTC"]]
   fir = multi_busy.map {|x| x[0].to_time.to_i}
   sec = sec = multi_busy.map {|x|  x[1].to_time.to_i}
   las = fir.zip(sec)
  end


end
