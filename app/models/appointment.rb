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


 def google_free_busy
 
 end 
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

def create_options(user, str)
    barber = get_barber(user)
    r = Chronic.parse("#{str}").to_s.split(" ")
    from = "#{r[0]}T#{barber.start_time.strftime("%H:%M")}".to_time
    to = "#{r[0]}T#{barber.end_time.strftime("%H:%M")}".to_time
    options = {from: from, to: to, tzid: "America/New_York"}
end
  
 def convert_time(arr)
    arr.map! {|x| Time.at(x).utc.strftime("%I:%M %p") }
 end

#TODO: send in time
def with_respect_to_date(response, id, date)
      barber  =  get_barber(id)
      multi_list = generate_multi_busy(response)#busy_list 
      free_list = generate_free_time(barber, date)
      pre_times = subtract_busy_time(free_list, multi_list)
      free_times = convert_time(pre_times)    
end


def get_barber(barber_id)
  @barber = User.where(id: barber_id).take
end


 
#last method before completing the Form object
# How to Remove the times: 
#grab the start and end time. check each value in the free time array 
#against the start and end range. Remove the free times that are within the
#range. Return the new free times array.

  def subtract_busy_time(free, busy)   
   list1 = free_times_to_integer(free)
   list2 = busy_times_to_integer(busy)
   beta_times = []
  
   list2.each do |x|
     list1.map do |y|                         
      beta_times.push(y) if (x[0]..x[1]).cover?(y) == true
     end 
   end
   real_times = remove_times(list1, beta_times)
  end

  def generate_multi_busy(tstr) 
     fir = tstr.map {|x| x['start'].time}
     sec = tstr.map {|x| x['end'].time}
     multi = fir.zip(sec)
  end

  #generate a list of times
  def generate_free_time(barber, date) 
    # t = Time.parse('Wed Dec 09 16:05:00 -0600 2009')
   times = barber.barber_availability
   new_times = make_it_respect_the_day(times, date)
   start_time = new_times[0].to_time
   arr = []
   until start_time > new_times[1].to_time
     arr.push(start_time.to_s) 
     start_time += 15.minutes
   end
   return arr
  end 

  def make_it_respect_the_day(times, date)
     available_times = []
     start_time = times[0][times[0].index("T"), times[0].length]
     end_time = times[1][times[1].index("T"), times[1].length]
     date_part = Chronic.parse("#{date}").to_s.split(" ")[0]
     new_start_time = "#{date_part}"+"#{start_time}"
     new_end_time = "#{date_part}"+"#{end_time}"
     available_times.push(new_start_time)
     available_times.push(new_end_time)
     available_times
  end

  def free_times_to_integer(tstr)
   free_times = tstr.map! {|x| x.to_time.to_i} 
  end

  def busy_times_to_integer(multi_busy)
   # multi_busy = [["2016-10-29 13:00:00 UTC", "2016-10-29 13:30:00 UTC"],["2016-10-29 15:00:00 UTC", "2016-10-29 15:30:00 UTC"], 
   #  ["2016-10-29 16:00:00 UTC", "2016-10-29 16:30:00 UTC"], ["2016-10-29 17:00:00 UTC","2016-10-29 17:30:00 UTC"]]
   fir = multi_busy.map {|x| x[0].to_time.to_i}
   sec = sec = multi_busy.map {|x|  x[1].to_time.to_i}
   las = fir.zip(sec)
  end

  def remove_times(list1, list2)
    list2.each do |x|
      list1.delete(x)
    end
    list1
  end
  
end
