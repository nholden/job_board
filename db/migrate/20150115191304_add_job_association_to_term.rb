class AddJobAssociationToTerm < ActiveRecord::Migration
  def change
    add_column :jobs, :term_id, :integer
    add_index :jobs, :term_id
  end
end
