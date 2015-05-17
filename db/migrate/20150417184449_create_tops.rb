class CreateTops < ActiveRecord::Migration
  def change
    create_table :tops do |t|
      t.text :batch_information, hash: true, default: {}
      t.integer :number
      t.string :file_name
      t.string :url
      t.text :properties
    end
  end
end
