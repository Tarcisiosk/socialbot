require 'rails_helper'

RSpec.describe HookController, type: :controller do
  let(:base_params) do
   JSON.parse('{"course_id":"42", "title":"course_name", "logo_url":"course_url", 
                "description":"course_description", "time_available":"2018-02-08T23:43:44.698Z"}')
  end

  let(:additional_params) do
   JSON.parse('{"format":"json", "controller":"hook", "action":"course_created_callback"}')
  end
  
  context 'when receiving callback data' do
    context 'with valid params' do
      before { ::Course.destroy_all }
      it 'calls the course handler' do
        expect(Handlers::CourseHandler).to receive(:handle_api_data)
          .with(ActionController::Parameters.new(base_params.merge(additional_params)))
        post :course_created_callback, format: :json, params: base_params
      end
    end

    context 'with invalid params' do
      before { ::Course.destroy_all }
      it 'does not raise exception' do
        expect do
          post :course_created_callback
        end.to_not raise_error
      end
    end
  end
end