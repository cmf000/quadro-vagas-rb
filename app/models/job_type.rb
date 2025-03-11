class JobType < ApplicationRecord
  validates :name, presence: true
  validates :active, inclusion: { in: [ true, false ] }
  validates :name, uniqueness: true
end
