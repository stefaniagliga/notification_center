class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.datetime :date, null: false
      t.timestamps
    end
  end
end
