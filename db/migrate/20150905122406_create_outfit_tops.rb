class CreateOutfitTops < ActiveRecord::Migration
  def change
    create_table :outfit_tops do |t|
      t.integer :outfit_id
      t.integer :top_id
      t.timestamps
    end
    add_index :outfit_tops, [:outfit_id, :top_id]
  end
end
