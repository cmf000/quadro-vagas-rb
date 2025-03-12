class JobType < ApplicationRecord
  enum :status, { active: 0, archived: 10 }
  has_many :job_postings
  validates :name, :status, presence: true
  validates :name, uniqueness: true
end
