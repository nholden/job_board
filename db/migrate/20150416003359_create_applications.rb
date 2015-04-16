class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.integer :user_id
      t.integer :job_id
      t.string :status

      t.timestamps
    end
    add_index :applications, :user_id
    add_index :applications, :job_id
  end
end
