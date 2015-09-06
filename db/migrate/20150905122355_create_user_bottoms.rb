class CreateUserBottoms < ActiveRecord::Migration
  def change
    create_table :user_bottoms do |t|
      t.integer :user_id
      t.integer :bottom_id
      t.timestamps
    end
    add_index :user_bottoms, [:user_id, :bottom_id]
  end
end
