# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  role                   :string
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  unique_code            :string
#  gcalendar_id           :string
#  subscribed             :boolean
#  stripeid               :string
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :appointments, foreign_key: :barber_id 
  has_many :referrals, foreign_key: :barber_id

  # validates :stripeid, presence: true
  #TODO: ADD Friendly Id to obfuscate user id

  def generate_unique_code 
    self.unique_code = SecureRandom.hex(3)
  end


  def barber_availability
    available_times = []
    starting = self.start_time.to_s.split(' ')
    result_1 = "#{starting[0]}T#{starting[1]}z"
    ending = self.end_time.to_s.split(' ')
    result_2 = "#{ending[0]}T#{ending[1]}z"
    available_times.push(result_1) 
    available_times.push(result_2)
    available_times
  end


  #ISO-8601 - "2016-10-29T00:00:00"   "2016-10-29T08:00:00"

  
end
