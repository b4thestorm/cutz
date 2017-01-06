class Admin::BarberController < ApplicationController

  def show
      @barber = User.where(id: params[:id]).take
      @clients = @barber.appointments.all
      if params[:appointment_type] == 'request_all'
        @clients = @barber.appointments.all
       elsif params[:appointment_type] == 'booked_appointments'
        @clients = @barber.appointments.all
      end
      @referrals = @barber.referrals
  # to retrieve a calendar event GET https://www.googleapis.com/calendar/v3/calendars/calendarId/events/eventId
  # to post a new event POST https://www.googleapis.com/calendar/v3/calendars/calendarId/events
  end

end
