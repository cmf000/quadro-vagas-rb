FactoryBot.define do
  factory :company_profile do
    sequence(:name) { |n| "Company Name #{n}" }
    sequence(:website_url) { |n| "http://company#{n}.com" }
    sequence(:contact_email) { |n| "contact@company#{n}.com" }
  end
end
