class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :jobs, :type, :term
  end
end
