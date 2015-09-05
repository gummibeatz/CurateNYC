class CreateUserBottoms < ActiveRecord::Migration
  def change
    create_table :user_bottoms do |t|
      t.integer :user_id
      t.integer :bottom_id
      t.timestamps
    end
  end
end
