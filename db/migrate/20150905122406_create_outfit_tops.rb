class CreateOutfitTops < ActiveRecord::Migration
  def change
    create_table :outfit_tops do |t|
      t.integer :outfit_id
      t.integer :top_id
      t.timestamps
    end
  end
end
