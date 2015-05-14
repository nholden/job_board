class RemoveUrlFromJobs < ActiveRecord::Migration
  def change
    remove_column :jobs, :url, :string
  end
end
