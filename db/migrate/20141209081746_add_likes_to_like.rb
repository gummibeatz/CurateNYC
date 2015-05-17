class AddLikesToLike < ActiveRecord::Migration
  def change
    add_column :likes, :likes, :text
  end
end
