class HookController < ApplicationController

  def course_created_callback
    if params[:course_id].present?
      Course.handle_api_data(params)
    end
    render body: nil
  end
end