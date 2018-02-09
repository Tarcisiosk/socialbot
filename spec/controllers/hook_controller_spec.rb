require 'rails_helper'

RSpec.describe HookController, type: :controller do
  let!(:params) { '{"course_id":"42", "title":"course_name", "logo_url":"course_url", 
                    "description":"course_description", "time_available":"2018-02-08T23:43:44.698Z"}' }

  context 'when receiving callback data' do
    context 'with valid params' do
      before { Course.destroy_all }
      it 'creates a course' do
        RestClient = double
        post :course_created_callback, format: :json, params: JSON.parse(params)
        course = Course.first
        expect(Course.count).to eq 1
        expect(course.title).to eq 'course_name'
        expect(course.logo_url).to eq 'course_url'
        expect(course.description).to eq 'course_description'
        expect(course.time_available).to eq "2018-02-08T23:43:44.698Z".to_time
      end
    end

    context 'with invalid params' do
      before { Course.destroy_all }
      it 'returns a message' do
        RestClient = double
        rest = double
        rest.stub(:code) { 400 }
        rest.stub(:body) { nil }
        RestClient.stub(:post) { rest }
        post :course_created_callback
        expect(Course.count).to eq 0
      end
    end
  end
end