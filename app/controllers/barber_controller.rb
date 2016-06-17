class BarberController < ApplicationController
  def show
  end

  def find
    @barber = User.where(unique_code: params[:barber_code]).take
    if @barber
       redirect_to barber_galleries_path(@barber.id)
    elsif @barber == nil
       redirect_to root_path
    end
  end


end
