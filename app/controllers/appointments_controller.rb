class AppointmentsController < ApplicationController
  def new
    @barber_id = params[:barber_id]
    @style_id = params[:style_id]
  end

  def create
    @appointment = Appointment.new(appointment_params)
  
    if @appointment.save 
      flash[:notice] = 'Request was sent'
      redirect_to root_path
    else 
      flash[:notice] = 'Something went wrong'
      render :new
    end 
  end

private 

def appointment_params
  params.require(:appointment).permit(:schedule_day, :start_time, :end_time, :barber_id)
end  
end
