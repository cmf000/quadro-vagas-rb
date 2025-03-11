class JobType < ApplicationRecord
  has_many :job_postings
  validates :name, presence: true
  validates :active, inclusion: { in: [ true, false ] }
  validates :name, uniqueness: true
end
