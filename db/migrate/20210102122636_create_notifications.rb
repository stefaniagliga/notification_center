class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.datetime :date, null: false
      t.integer :created_by, null: false, index: true
      t.timestamps
    end
  end
end
