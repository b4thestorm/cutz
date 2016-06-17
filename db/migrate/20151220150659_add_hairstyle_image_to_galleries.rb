class AddHairstyleImageToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :hairstyle_image_id, :string
  end
end
