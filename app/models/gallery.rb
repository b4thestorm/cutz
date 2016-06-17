<<<<<<< HEAD
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

  
=======
>>>>>>> 6947862d140fc2f3316bf6bc6da77f5f3df23af7
end
