class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.integer :sender_id
      t.integer :accepter_id
      t.integer :status, default: 0
    end
  end
end
