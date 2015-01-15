class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.text :label

      t.timestamps
    end
  end
end
