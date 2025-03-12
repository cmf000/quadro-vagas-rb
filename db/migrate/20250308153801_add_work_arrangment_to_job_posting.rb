class AddWorkArrangmentToJobPosting < ActiveRecord::Migration[8.0]
  def change
    add_column :job_postings, :work_arrangement, :string
  end
end
