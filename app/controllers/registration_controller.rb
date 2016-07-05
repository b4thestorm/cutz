class RegistrationController < Devise::RegistrationsController 
  layout 'devise', only: [:new]

  def new
    # super
    build_resource({})
  end 

  def create
    @user = User.new(sign_up_params)
    
    token = params[:stripeToken]
    email = params[:email]
    customer = Stripe::Customer.create(
        card:  token,
        plan:  Stripe::Plans::PRIME,
        email: email 
     )
   
    @user.subscribed = true
    @user.stripeid = customer.id
    @user.generate_unique_code 
    if @user.save 
        sign_in @user
        redirect_to barber_path(@user), notice: "Welcome to Cutz" 
    end
  end   

  protected 

  def configure_sign_up_params
      devise_parameter_sanitizer.for(:sign_up).push(:stripeid, :subscribed)
   end

  def after_sign_up_path_for(resource)
     barber_path(resource.id)
  end
end 
