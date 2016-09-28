class Referral < ActiveRecord::Base
  belongs_to :barber, class_name: 'User', foreign_key: :barber_id

 
  def ref_code 
   #TODO create a new link referral code to share    
  end 

end
