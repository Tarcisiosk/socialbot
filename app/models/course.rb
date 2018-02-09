class Course < ApplicationRecord
  validates :title, presence: true

  after_create :publish

  def formatted_available_date
    time_available&.strftime("%D - %T")
  end

  def self.handle_api_data(data = nil)
    return unless data.present? && data&.dig('course_id').to_i != 0
    course = self.where(id: data.dig('course_id')).first_or_initialize
    course.title = data.dig('title')
    course.description = data.dig('description')
    course.time_available = data.dig('time_available')&.to_time
    course.logo_url = data.dig('logo_url')
    course.save
  end

  private
  
  def publish
    Bot.tweet I18n.t('course.tweet', {course_name: title, 
                                      course_description: description,
                                      course_date: formatted_available_date})
  end
  
end
