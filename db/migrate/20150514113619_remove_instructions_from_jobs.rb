class RemoveInstructionsFromJobs < ActiveRecord::Migration
  def change
    remove_column :jobs, :instructions, :string
  end
end
