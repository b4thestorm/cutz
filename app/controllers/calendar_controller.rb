class CalendarController < ApplicationController

def index
  #data can be passed to/from calendar to here. 
  @calendar = Calendar.new
end

end
