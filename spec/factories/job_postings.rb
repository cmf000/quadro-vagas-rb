FactoryBot.define do
  factory :job_posting do
    sequence(:title) { |n| "Job Title #{n}" }
    company_profile { create(:company_profile) }
    sequence(:salary) { |n| "Salary #{n}" }
    salary_currency { "USD" }
    salary_period { "Monthly" }
    job_type { create(:job_type) }
    description { "Something" }
  end
end
