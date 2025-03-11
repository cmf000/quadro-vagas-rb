FactoryBot.define do
  factory :job_type do
    name { [ "Full Time", "Part Time", "Freelance" ].sample }
  end
end
