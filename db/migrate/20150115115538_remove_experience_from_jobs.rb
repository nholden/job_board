class RemoveExperienceFromJobs < ActiveRecord::Migration
  def change
    remove_column :jobs, :experience, :text
  end
end
