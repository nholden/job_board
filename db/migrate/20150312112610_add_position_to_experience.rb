class AddPositionToExperience < ActiveRecord::Migration
  def change
    add_column :experiences, :position, :integer
  end
end
