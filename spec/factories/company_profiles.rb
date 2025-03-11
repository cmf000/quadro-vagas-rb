FactoryBot.define do
  factory :company_profile do
    association :user
    name { "BlinkedOn" }
    website_url { "https://blinkedon.tech" }
    contact_email { "contact@blinkedon.tech" }
    logo { File.open(Rails.root.join('spec/support/files/logo.jpg'), filename: 'logo.jpg') }
  end
end
