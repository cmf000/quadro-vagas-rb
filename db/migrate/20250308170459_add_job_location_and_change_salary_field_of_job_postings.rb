class AddJobLocationAndChangeSalaryFieldOfJobPostings < ActiveRecord::Migration[8.0]
  def change
    add_column :job_postings, :job_location, :string
    change_column :job_postings, :salary, 'decimal USING CAST(salary AS decimal)', precision: 10, scale: 2
  end
end
