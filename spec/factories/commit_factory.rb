FactoryGirl.define do
  factory :commit do
    begin_time { DateTime.now.utc.beginning_of_day + 1.hour }
    end_time { DateTime.now.utc.beginning_of_day + 2.hour }
    spent_time 60
  end
end