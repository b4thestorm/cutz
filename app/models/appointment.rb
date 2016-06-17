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
#

class Appointment < ActiveRecord::Base
  belongs_to :barber, class_name: 'User', foreign_key: :barber_id

  
end
