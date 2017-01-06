class BarberController < ApplicationController

  def find
    @barber = User.where(unique_code: params[:barber_code]).take
    if @barber
       redirect_to barber_galleries_path(@barber.id)
    elsif @barber == nil
       redirect_to root_path
    end
  end


#TODO: INSERT STRONG PARAMS HERE FOR UNIQUE_CODE


end
