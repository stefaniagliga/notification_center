class CreateUserNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :user_notifications do |t|
      t.integer :user_id, null: false, index: true
      t.integer :notification_id, null: false, index: true
      t.boolean :seen, default: false
      t.timestamps
    end
  end
end
