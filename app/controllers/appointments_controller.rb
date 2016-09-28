class AppointmentsController < ApplicationController
before_action :check_token, only: :index

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

 #get freebusy data and pass it into List
   #needs to refresh token after a certain time frame 
 #/:barber_id/appointments
  def index
    
      # current = User.where(email: current_user.email).take
      options = {from: "2016-09-29T00:00:00".to_time, to: "2016-09-30T12:00:00".to_time, tzid: 'America/New_York' }
      @response = @cronofy.free_busy(options)


   # redirect_to barber_path(current_user.id)
  end


  

 
private 

  def appointment_params
    params.require(:appointment).permit(:schedule_day, :start_time, :end_time, :barber_id)
  end  

  def check_token 
     # user = User.where(email: current_user.email).take
     time = DateTime.strptime("#{current_user.expiration}",'%s')  

     if time > Time.now 
      #Use the refresh token to initiate an object
        cronofy = Cronofy::Client.new( refresh_token: current_user.cronofy_refresh_token)
        token = cronofy.refresh_access_token
            #Save new data to User 
            current_user.cronofy_access_token =  token.access_token
            current_user.cronofy_refresh_token = token.refresh_token
            current_user.expiration = token.expires_at 
            current_user.save
        #send new authorized cronofy object
        @cronofy = Cronofy::Client.new(access_token: current_user.cronofy_access_token)
      else
      #initiate an Object
        @cronofy = Cronofy::Client.new( access_token: current_user.cronofy_access_token)
     end 
  end


end
