class GalleriesController < ApplicationController
  def index
    @photo = Gallery.all
  end

  def new 
    @photo = Gallery.new
  end 

  def create 
    @photo = Gallery.new(photo_params)
    if @photo.save 
    flash[:notice] = "Image Added"
    redirect_to barber_galleries_path
    else 
    render :new
    end
  end

  def destroy 
    @photo = Gallery.find(id: params[:id])
    if @photo.destroy
    flash[:notice] = "Photo was successfully deleted"
    render :new
    end
  end

  private 
  def photo_params
    params.require(:gallery).permit(:hairstyle_image)
  end

end
