class CreateTops < ActiveRecord::Migration
  def change
    create_table :tops do |t|
      t.string :url
      t.string :file_name
      t.integer :main_category, default: 0
      t.string :clothing_type
      t.string :collar_type
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
      t.boolean :first_layer
      t.boolean :second_layer
      t.boolean :third_layer
      t.boolean :fourth_layer
      t.boolean :priority
      t.integer :row_number
      t.timestamps
    end
    add_index :tops, [:file_name, :color_1]
  end
end
