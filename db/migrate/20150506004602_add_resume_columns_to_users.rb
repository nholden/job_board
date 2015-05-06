class AddResumeColumnsToUsers < ActiveRecord::Migration
  def self.up 
    add_attachment :users, :resume
  end

  def self.down
    remove_attachment :users, :resume
  end
end
