class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :commentable_id
      t.string :commentable_type
      t.integer :user_id
      t.integer :parents_id
      t.string :content

      t.timestamps
    end
  end
end
