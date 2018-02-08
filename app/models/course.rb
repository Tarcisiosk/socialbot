class Course < ApplicationRecord
  validates :name, :url, :description, presence: true

  after_create :publish

  private
  
  def publish
    Bot.tweet I18n.t('course.tweet', {course_name: name, 
                                      course_description: description, 
                                      course_url: url})
  end

end
