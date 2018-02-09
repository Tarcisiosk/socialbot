class Course < ApplicationRecord
  validates :title, presence: true

  after_create :publish

  private

  def decorate_object
    self.decorate
  end 
  
  def publish
    decorated_course = decorate_object
    Bot.tweet I18n.t('course.tweet', { course_name: decorated_course.title, 
                                       course_description: decorated_course.description,
                                       course_date: decorated_course.time_available })
  end
end
