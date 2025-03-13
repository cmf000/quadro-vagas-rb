FactoryBot.define do
  factory :experience_level do
    sequence(:name) { |n| "Experience level #{n}" }
    status { :active }
  end
end
