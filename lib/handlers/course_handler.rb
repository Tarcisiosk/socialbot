module Handlers
  class CourseHandler
    def self.handle_api_data(data = nil)
      return unless data.present? && data&.dig('course_id').to_i != 0
      course = ::Course.where(id: data.dig('course_id')).first_or_initialize
      course.title = data.dig('title')
      course.description = data.dig('description')
      course.time_available = data.dig('time_available')&.to_time
      course.logo_url = data.dig('logo_url')
      course.save
    end
  end
end