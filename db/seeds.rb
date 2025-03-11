# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Delete all records from the database
CompanyProfile.delete_all
JobPosting.delete_all
JobType.delete_all

# Creates three job types
[ "Full Time", "Part Time", "Freelance" ].each do |job_type_name|
  JobType.create!(name: job_type_name)
end

# Creates three company profiles
3.times do |n|
  CompanyProfile.create!(name: "Company Name #{n}", website_url: "http://company#{n}.com", contact_email: "contact@company#{n}.com")
end

# Creates three job postings
JobPosting.create!(title: "Dev React", company_profile: CompanyProfile.first, salary: "1000.00", salary_currency: "USD", salary_period: "Monthly", job_type: JobType.first, description: "There’s nothing better than hiking along the rocky footpaths, accompanied only by the noise of cicadas. As the boat docks in the harbor, gaze upon white and blue houses, craggy cliffs, sweeping olive groves, and the dazzling blues of the Aegean sea.")
JobPosting.create!(title: "Dev Node", company_profile: CompanyProfile.second, salary: "5000.00", salary_currency: "USD", salary_period: "Monthly", job_type: JobType.second, description: "There’s nothing better than hiking along the rocky footpaths, accompanied only by the noise of cicadas. As the boat docks in the harbor, gaze upon white and blue houses, craggy cliffs, sweeping olive groves, and the dazzling blues of the Aegean sea.")
JobPosting.create!(title: "Dev RoR", company_profile: CompanyProfile.last, salary: "10000.00", salary_currency: "USD", salary_period: "Monthly", job_type: JobType.last, description: "There’s nothing better than hiking along the rocky footpaths, accompanied only by the noise of cicadas. As the boat docks in the harbor, gaze upon white and blue houses, craggy cliffs, sweeping olive groves, and the dazzling blues of the Aegean sea.")
