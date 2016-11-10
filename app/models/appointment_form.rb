class AppointmentForm 
  include ActiveModel::Model
  include ActiveModel::Validations
  DATES = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']

  #creates a mapping for an appointment 
  attr_accessor(:name, :start_time, :summary, :barber_id)

  validates :name, presence: true
  validates :start_time, presence: true

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def register
      record = Appointment.new(name: self.name, start_time: self.start_time, summary: self.summary, barber_id: self.barber_id, schedule_day: self.start_time)
      record.save
  end

end
