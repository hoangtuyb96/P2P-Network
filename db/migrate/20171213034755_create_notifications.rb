class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :notificationable_id
      t.string :notificationable_type
      t.string :content

      t.timestamps
    end
  end
end
