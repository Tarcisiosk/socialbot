FactoryBot.define do
  factory :course do
    title 'Awesome Course'
    description = 'a mind blowing course about life and universe'
    time_available = "2018-02-08T23:43:44.698Z".to_time
    logo_url = 'whatisgoingon.com'
  end
end
