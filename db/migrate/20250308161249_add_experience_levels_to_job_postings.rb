class AddExperienceLevelsToJobPostings < ActiveRecord::Migration[8.0]
  def change
    add_reference :job_postings, :experience_level, null: false, foreign_key: true
  end
end
