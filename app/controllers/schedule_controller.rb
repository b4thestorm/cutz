class ScheduleController < ApplicationController
require 'google/apis/calendar_v3'  
require 'uri'
require 'net/http'

  def new 

  end

  def create

  end

  def gcal_redirect
    schedule = Schedule.new
    client = schedule.calendar_redirect
    redirect_to client.authorization_uri.to_s
  end

  def cutz_callback
    @barber = current_user.id
    schedule = Schedule.new
    response = schedule.get_access_token(params[:code])
    if response
      session[:access_token] = response['access_token']
    end
      redirect_to barber_path(@barber)

  end
 
  def new_calendar 
    schedule = Schedule.new
    service = schedule.authorized_calendar_call(session[:access_token])
    calendar = schedule.new_calendar_summary
    result = service.insert_calendar(calendar)
    redirect_to barber_path(current_user.id)
  end 

  def get_calendar_id
    schedule = Schedule.new
    service = schedule.authorized_calendar_call(session[:access_token])
    schedule.get_and_save_calendar_id(service, current_user)
    redirect_to barber_path(current_user.id)
  end

  #TODO Fix the time.
  def add_appointment 

   schedule = Schedule.new
   if params[:appt_id]
      event = schedule.add_appointment(params[:appt_id], current_user.id)
      service = schedule.authorized_calendar_call(session[:access_token])
      service.insert_event(current_user.gcalendar_id, event)
   end

   redirect_to barber_path(current_user.id)
  end

 
 


end
