class CreateEmployers < ActiveRecord::Migration
  def change
    create_table :employers do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.text :description
      t.string :website

      t.timestamps
    end
  end
end
