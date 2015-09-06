class CreateUserTops < ActiveRecord::Migration
  def change
    create_table :user_tops do |t|
      t.integer :user_id
      t.integer :top_id
      t.timestamps
    end
    add_index :user_tops, [:user_id, :top_id]
  end
end
