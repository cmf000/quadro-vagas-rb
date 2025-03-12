class ChangeJobPostingEnumsToInteger < ActiveRecord::Migration[8.0]
  def change
    change_column :job_postings, :salary_currency, :integer, using: 'salary_currency::integer'
    change_column :job_postings, :salary_period, :integer, using: 'salary_period::integer'
    change_column :job_postings, :work_arrangement, :integer, using: 'work_arrangement::integer'
  end
end
