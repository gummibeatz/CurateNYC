class CreateBottoms < ActiveRecord::Migration
  def change
    create_table :bottoms do |t|
      t.integer :outfit_id
      
      t.string :url
      t.string :file_name
      t.integer :main_category, default: 0
      t.string :clothing_type
      t.string :clothing_type_2
      t.string :pleat
      t.string :material
      t.string :brand
      t.string :pattern
      t.string :color_1
      t.string :color_2
      #may think about using bit fields for these bools
      t.boolean :spring
      t.boolean :summer
      t.boolean :fall 
      t.boolean :winter
      t.boolean :warm
      t.boolean :hot
      t.boolean :brisk
      t.boolean :cold
      t.boolean :casual
      t.boolean :going_out
      t.boolean :dressy
      t.boolean :formal
      t.boolean :priority
      t.integer :row_number
      t.timestamps
    end
  end
end
