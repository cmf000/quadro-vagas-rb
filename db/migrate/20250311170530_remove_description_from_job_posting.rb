class RemoveDescriptionFromJobPosting < ActiveRecord::Migration[8.0]
  def change
    remove_column :job_postings, :description, :text
  end
end
