class ReferralsController < ApplicationController
  include ReferralsHelper

  def question 
    @referral = Referral.new(barber_id: params[:barber_id], state: to_bool(params[:referral][:state]))
    if @referral.save 
      flash[:notice] = "Thank you"
      redirect_to barber_galleries_path
    end
  end 
end
