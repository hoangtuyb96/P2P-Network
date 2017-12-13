class CreateStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :statuses do |t|
      t.text :content
      t.integer :user_id
      t.integer :group_id

      t.timestamps
    end
  end
end
