class Referral < ActiveRecord::Base
  belongs_to :barber, class_name: 'User', foreign_key: :barber_id
end
