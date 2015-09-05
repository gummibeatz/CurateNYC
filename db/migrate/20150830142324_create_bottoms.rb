class CreateBottoms < ActiveRecord::Migration
  def change
    create_table :bottoms do |t|
      t.integer :outfit_id
      t.timestamps
    end
  end
end
