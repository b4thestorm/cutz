class GalleriesController < ApplicationController
  def index
    @photo = Gallery.first
  end

  def new 
    @photo = Gallery.new
  end 

  def create 
    @photo = Gallery.new(photo_params)
    if @photo.save 
    flash[:notice] = "Image Added"
    redirect_to galleries_path
    else 
    render :new
    end
  end

  private 
  def photo_params
    params.require(:gallery).permit(:hairstyle_image)
  end

end
