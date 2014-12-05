class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.text :title
      t.text :type
      t.text :location
      t.text :experience
      t.text :majors
      t.text :description
      t.text :url
      t.text :instructions
      t.date :deadline
      t.text :salary
      t.references :user, index: true

      t.timestamps
    end
    add_index :jobs, [:user_id, :created_at]
  end
end
