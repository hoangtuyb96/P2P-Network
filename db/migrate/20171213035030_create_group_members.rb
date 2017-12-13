class CreateGroupMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :group_members do |t|
      t.integer :group_id
      t.integer :user_id
      t.integer :permission, default: 0
    end
  end
end
