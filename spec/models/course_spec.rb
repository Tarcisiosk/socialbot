require 'rails_helper'

RSpec.describe Course, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end

  context 'when creating a new course' do 
    let(:course) { FactoryBot.build(:course) }

    it 'generates a tweet to publish' do
      expect(course).to receive(:publish)
      course.save
    end
  end

  context 'when receiving api data' do

    context 'with valid params' do
      let(:valid_params) { {"course_id"=>"999", "title"=>"test", "logo_url"=>"test.com", "description"=>"this is a test", 
                            "time_available"=>"2018-02-08T23:43:44.698Z"} }

      context 'when new' do
        before { Course.destroy_all }
        it 'creates a new course' do
          Course.handle_api_data(valid_params)
          course = Course.first
          expect(Course.count).to eq 1
          expect(course.title).to eq 'test'
          expect(course.logo_url).to eq 'test.com'
          expect(course.description).to eq 'this is a test'
          expect(course.time_available).to eq '2018-02-08T23:43:44.698Z'.to_time
        end
      end

      context 'when existent' do
        let(:course){ FactoryBot.create(:course, id: "999", logo_url: "whatisgoingon.com", 
                                         description: "a mind blowing course about life and universe") }
        it 'updates the course' do
          expect(course.title).to eq "Awesome Course"
          expect(course.logo_url).to eq "whatisgoingon.com"
          expect(course.description).to eq "a mind blowing course about life and universe"
          Course.handle_api_data(valid_params)
          course.reload
          expect(course.title).to eq 'test'
          expect(course.logo_url).to eq 'test.com'
          expect(course.description).to eq 'this is a test'
          expect(course.time_available).to eq '2018-02-08T23:43:44.698Z'.to_time
        end
      end
    end

    context 'with invalid params' do
      let(:invalid_params)  { {"invalid"=>""} }
      before { Course.destroy_all }

      it 'does not save and show no error when invalid' do
        expect{Course.handle_api_data(invalid_params)}.to_not raise_error
        expect(Course.count).to eq 0
      end

      it 'does not save and show no error when nil' do
        expect{Course.handle_api_data(nil)}.to_not raise_error
        expect(Course.count).to eq 0
      end
    end

    context "#formatted_available_date" do
      context "with valid" do
        let(:course){ FactoryBot.create(:course, id: "999", time_available: "2018-02-08T23:43:44.698Z".to_time) }
        it 'returns a fomatted date' do
          expect(course.formatted_available_date).to eq"02/08/18 - 23:43:44"
        end
      end

      context "with invalid" do
        let(:course){ FactoryBot.create(:course, id: "999", time_available: nil) }
        it 'does not raise a error' do
          expect{course.formatted_available_date}.to_not raise_error
        end
      end
    end
  end
end
