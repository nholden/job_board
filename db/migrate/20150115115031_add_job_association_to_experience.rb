class AddJobAssociationToExperience < ActiveRecord::Migration
  def change 
    add_column :jobs, :experience_id, :integer
    add_index :jobs, :experience_id
  end
end
