class AddOutfitsToOutfit < ActiveRecord::Migration
  def change
    add_column :outfits, :outfits, :text
  end
end
