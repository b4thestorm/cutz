# == Schema Information
#
# Table name: galleries
#
#  id                 :integer          not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  hairstyle_image_id :string
#

class Gallery < ActiveRecord::Base
  attachment :hairstyle_image

  

end
