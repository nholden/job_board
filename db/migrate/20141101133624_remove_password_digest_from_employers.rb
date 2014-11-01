class RemovePasswordDigestFromEmployers < ActiveRecord::Migration
  def change
    remove_column :employers, :password_digest
  end
end
