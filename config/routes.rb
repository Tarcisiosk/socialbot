Rails.application.routes.draw do
  scope '/hook', :controller => :hook do
    post :course_created_callback
  end

end
