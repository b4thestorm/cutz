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
end
