FactoryGirl.define do
  factory :item do
    sequence(:name) { |n| "calculo#{n}" }
    estimated_time 240
  end	
end