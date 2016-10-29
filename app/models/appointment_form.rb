class AppointmentForm 
  include ActiveModel::Model
  include ActiveModel::Validations
  DATES = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']

  #creates a mapping for an appointment 
  attr_accessor(:name, :style, :start_time, :summary)

  validates :name, presence: true
  validates :style, presence: true
  validates :start_time, presence: true
 
  def register
    if valid?
      # self.name = name
      # self.style = 
      # self.start_time = 
      # self.summary = 

      # Do something interesting here
      # - create user
    end
  end

end
