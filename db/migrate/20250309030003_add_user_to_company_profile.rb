class AddUserToCompanyProfile < ActiveRecord::Migration[8.0]
  def change
    add_reference :company_profiles, :user, null: false, foreign_key: true
  end
end
