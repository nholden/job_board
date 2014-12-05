class RenameEmployersToUsers < ActiveRecord::Migration
  def self.up
    rename_table :employers, :users
  end
  def self.down
    rename_table :employers, :users
  end
end
