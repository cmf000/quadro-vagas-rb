class AddJobTypeToJobPostings < ActiveRecord::Migration[8.0]
  def change
    add_reference :job_postings, :job_type, null: false, foreign_key: true
  end
end
