require 'rails_helper'

RSpec.describe CourseDecorator do
  
  context "#time_available" do
    context "with valid" do
      let(:course){ FactoryBot.create(:course, id: "999", time_available: "2018-02-08T23:43:44.698Z".to_time).decorate }
      
      it 'returns a fomatted date' do
        expect(course.time_available).to eq "02/08/18 - 23:43:44"
      end
    end

    context "with invalid" do
      let(:course){ FactoryBot.create(:course, id: "999", time_available: nil).decorate }
      
      it 'does not raise a error' do
        expect{ course.time_available }.to_not raise_error
      end
    end
  end
end
