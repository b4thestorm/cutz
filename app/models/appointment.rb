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
#

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
  
end
