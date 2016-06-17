class AppointmentsController < ApplicationController
  def new
    @barber_id = params[:barber_id]
    @appt = Appointment.new
  end

  def create
    #TODO add a barber appointment path
  end
end
