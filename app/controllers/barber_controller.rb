class BarberController < ApplicationController
  def show
    @barber = User.where(id: params[:id]).take
    @clients = @barber.appointments.all
# to retrieve a calendar event GET https://www.googleapis.com/calendar/v3/calendars/calendarId/events/eventId
# to post a new event POST https://www.googleapis.com/calendar/v3/calendars/calendarId/events
  end

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
