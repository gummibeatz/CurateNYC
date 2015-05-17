class AddClothesToWardrobe < ActiveRecord::Migration
  def change
    add_column :wardrobes, :wardrobe, :text
  end
end
