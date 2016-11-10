# == Schema Information
#
# Table name: schedules
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Schedule < ActiveRecord::Base
# require 'google/apis/calendar_v3'
require 'net/http'

 
  #TODO: Make the add appointments method programmatic
  def list_of_calendars(cron)
    begin 
      calendars = cron.list_calendars
      barber_calendar = calendars.select! {|x| x["calendar_id"] if x["calendar_name"] == "Barber Calendar"}.reject {|e| e.nil?}
      barber_id = barber_calendar[0]
    rescue 
       return { :error => "Sorry, No Data returned. Try Again"}
    end 
  end

  def add_new_appointment
    
  end

  # def calendar_redirect 
  #    client = Signet::OAuth2::Client.new({
  #     client_id: ENV["GOOGLE_CLIENT_ID"],
  #     client_secret: ENV["GOOGLE_CLIENT_SECRET"],
  #     authorization_uri: 'https://accounts.google.com/o/oauth1/auth',
  #     scope: 'https://www.googleapis.com/auth/calendar',
  #     redirect_uri: 'http://localhost:3000/schedule/cutz_callback'
  #   })
  # end 

  # def get_access_token(code) 
  #    client = Signet::OAuth2::Client.new({
  #     client_id: ENV["GOOGLE_CLIENT_ID"],
  #     client_secret: ENV["GOOGLE_CLIENT_SECRET"],
  #     token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
  #     redirect_uri: 'http://localhost:3000/schedule/cutz_callback',
  #     code: code
  #     })
  #     response = client.fetch_access_token!
  # end 

  # def authorized_calendar_call(token)
  #   client = Signet::OAuth2::Client.new(access_token: token)
  #   service = Google::Apis::CalendarV3::CalendarService.new
  #   service.authorization = client
  #   service
  # end

  # def new_calendar_summary
  #   calendar = Google::Apis::CalendarV3::Calendar.new(
  #     summary: 'Barber Calendar',
  #     decription: 'Client Calendar',
  #     time_zone: 'America/New_York'
  #   )
  #   calendar
  # end

  # def get_and_save_calendar_id(service, user)
  #   @calendar_list = service.list_calendar_lists
  #   response = JSON.parse(@calendar_list.to_json)
  #   calendar_id = response['items'].select{|x|  x['id'] if x['summary'] == 'Barber Calendar'}
  #   calendar_id[0]['id']
  #   user.gcalendar_id = calendar_id[0]['id']
  #   user.save
  # end

  #TODO pass the appointment object into this method and parse it
  # def add_appointment(appt_id, user)
  #   appt = Appointment.where(id: appt_id).take
  #   from = appt.fix_start_time
  #   to = appt.fix_end_time

  #   event = Google::Apis::CalendarV3::Event.new({
  #    'summary':'Haircut Appointment',
  #    'location':'800 Howard St., San Francisco, CA 94103',
  #    'description':'Dark Caesar',
  #    'start':{
  #           'date_time': from,
  #           'time_zone': 'America/New_York'
  #            },
  #    'end':{
  #           'date_time':  to,
  #           'time_zone': 'America/New_York'
  #          }
  #     })
  #   event
  # end 
  
   ###### Barber Available Time Algorithm 

   def booked_appointments(user)
     item_array = Array.new
     item_array << user.gcalendar_id
     body = Google::Apis::CalendarV3::FreeBusyRequest.new 
     body.items = item_array
     body.time_min = "2019-09-29T00:00:00Z"
     body.time_max = "2016-09-29T12:00:00Z"
     body
   end

   def fix_query_time

   end 

  #Pass an authenticated service object in and make a call parse the return object for the  
  #event id

  #pass the event id, authenticated service object and then the barbers calendar id. 
  def cancel_appointment
    # service.delete_event(calendar_id, event_id )
  end
  

end
