class Calendar 
require 'chronic'

require 'active_support/all'
#this class is responsible for creating the time calendar view

#TODO: a business day is from 9am - 8pm

def time_range_for_business_day(day)
thirty_minutes = 60 * 30
from_time = Chronic.parse("#{day} at 9am").to_i
to_time = Chronic.parse("#{day} at 8pm").to_i
(from_time..to_time).step(thirty_minutes).map{ |t| Time.at( t ).to_datetime }
end

def time_range_for_week 
 days_of_week = ['sunday','monday','tuesday','wednesday','thursday','friday','saturday']
 n = 0
 day_ranges = Array.new
  7.times do
   day_ranges << time_range_for_business_day(days_of_week[n]) 
   n+= 1
  end
 day_ranges
end

#day is the row 
#time is the data cell







end 
