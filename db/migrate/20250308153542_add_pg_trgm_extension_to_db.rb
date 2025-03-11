class AddPgTrgmExtensionToDb < ActiveRecord::Migration[8.0]
  def change
    execute "create extension pg_trgm;"
  end
end
