class CreateBottoms < ActiveRecord::Migration
  def change
    create_table :bottoms do |t|

      t.timestamps
    end
  end
end
