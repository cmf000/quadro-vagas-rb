class AddDescriptionToJobPostings < ActiveRecord::Migration[8.0]
  def change
    add_column :job_postings, :description, :text
  end
end
