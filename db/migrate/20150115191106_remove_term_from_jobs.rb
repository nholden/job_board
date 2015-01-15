class RemoveTermFromJobs < ActiveRecord::Migration
  def change
    remove_column :jobs, :term, :text
  end
end
