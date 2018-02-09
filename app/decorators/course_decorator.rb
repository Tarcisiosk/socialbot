class CourseDecorator < ApplicationDecorator
  delegate_all

  def time_available
    object.time_available&.strftime("%D - %T")
  end
end
