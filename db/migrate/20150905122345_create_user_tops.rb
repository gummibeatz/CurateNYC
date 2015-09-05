class CreateUserTops < ActiveRecord::Migration
  def change
    create_table :user_tops do |t|
      t.integer :user_id
      t.integer :top_id
      t.timestamps
    end
  end
end
