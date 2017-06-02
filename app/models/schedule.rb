# == Schema Information
#
# Table name: schedules
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
class Schedule < ActiveRecord::Base
# require 'google/apis/calendar_v2'
require 'net/http'


  def google_free_busy
   response = Net::HTTP::Post.new(URI('https://www.googleapis.com/calendar/v3/freeBusy'))
   response.methods
   
   # , {
   #        "timeMin": "2017-06-02T00:00:00+0000",
   #        "timeMax": "2017-06-02T20:00:00+0000",
   #        "timeZone": "america/new_york",
   #         "items": [
   #         {
   #            "id": "arnold@usefomo.com"
   #          }
   #         ]
   #       }.to_json )
  end 
  
  def add_appointment(appt_id, appt, barber)
    calendar_id = get_list(barber)
    calendar_id = barber.gcalendar_id
    u = Appointment.where(id: appt_id).take
    event_data = { "event_id": u.id, 
    "summary": 'Haircut', 
    "start": u.start_time,
    "end": u.start_time + (30 * 60),
    "location": {
      description: "Haircut"
      }
    }  
   cron = Cronofy::Client.new(access_token: barber.cronofy_access_token)
   cron.upsert_event(calendar_id, event_data)
  end

  def get_list(barber)
      cron = Cronofy::Client.new(access_token: barber.cronofy_access_token)
      schedule = Schedule.new
      request = schedule.list_of_calendars(cron)
      barber.gcalendar_id = request["calendar_id"]
      barber.save
  end 

  #TODO: Make the add appointments method programmatic
  def list_of_calendars(cron)
    begin 
      calendars = cron.list_calendars
      barber_calendar = calendars.select! {|x| x["calendar_id"] if x["calendar_name"] == "Barber Calendar"}.reject {|e| e.nil?}
      barber_id = barber_calendar[0]
    rescue 
       return { :error => "Sorry, Something went wrong. Try Again"}
    end 
  end

    def cancel_appointment(barber, appt_id)
    cron = Cronofy::Client.new(access_token: barber.cronofy_access_token)
    cron.delete_event(barber.gcalendar_id, appt_id)
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


  

end
