class HookController < ApplicationController
  def course_created_callback
    ::Handlers::CourseHandler.handle_api_data(params)
    render body: nil
  end
end