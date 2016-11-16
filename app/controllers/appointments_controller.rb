class AppointmentsController < ApplicationController
include AppointmentsHelper
before_action :check_token, only: :new
  #TODO: send a default :q params to new action and set it equal to the current day
  def new
    @barber_id = params[:barber_id]
    barber = User.where(id: @barber_id).take
    # @style_id = params[:style_id]
    time = params[:q]
    @style = params[:style]  # options = {from: "2016-10-29T08:00:00".to_time , to: "2016-10-29T20:00:00".to_time , tzid: "America/New_York" }
    if params[:q] 
      #####################################################################
      @appointment = AppointmentForm.new
      appointments = Appointment.new
        options = appointments.create_options(@barber_id, params[:q])
        begin
        response = @cronofy.free_busy(options).to_a
        rescue
           cronofy = Cronofy::Client.new( refresh_token: barber.cronofy_refresh_token)
           token = cronofy.refresh_access_token
            #Save new data to User 
            barber.cronofy_access_token =  token.access_token
            barber.cronofy_refresh_token = token.refresh_token
            barber.expiration = token.expires_at 
            barber.save
        #send new authorized cronofy object
        @cronofy = Cronofy::Client.new(access_token: barber.cronofy_access_token)
        end
         response = @cronofy.free_busy(options).to_a
      #####################################################################
        if response.empty?
          @free_times =  appointments.generate_free_time(barber, time)
        else
            @free_times = appointments.with_respect_to_date(response, params[:barber_id], time)
        end
    end
  end

  def create
    @appointment = AppointmentForm.new(appointment_params.merge(barber_id: params[:barber_id]))
    if @appointment.valid?
      @appointment.register
        flash[:notice] = 'Request was sent'
      redirect_to root_path
    else 
      flash[:notice] = 'Something went wrong'
      render :new
    end 
  end

 #/:barber_id/appointments
  def index

   # redirect_to barber_path(current_user.id)
  end


  

 
private 

  def appointment_params
    params.require(:appointment_form).permit(:name, :start_time, :phone, :email, :barber_id)
  end  

  def check_token 
     # user = User.where(email: current_user.email).take
     barber = User.where(id: params[:barber_id]).take 
     time = DateTime.strptime("#{barber.expiration}",'%s')  
     if time > Time.now 
      #Use the refresh token to initiate an object
        cronofy = Cronofy::Client.new( refresh_token: barber.cronofy_refresh_token)
        token = cronofy.refresh_access_token
            #Save new data to User 
            barber.cronofy_access_token =  token.access_token
            barber.cronofy_refresh_token = token.refresh_token
            barber.expiration = token.expires_at 
            barber.save
        #send new authorized cronofy object

        @cronofy = Cronofy::Client.new(access_token: barber.cronofy_access_token)
      else
      #initiate an Object
         @cronofy = Cronofy::Client.new( access_token: barber.cronofy_access_token)
      end 
  end



end
