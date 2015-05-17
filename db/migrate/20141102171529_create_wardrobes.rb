class CreateWardrobes < ActiveRecord::Migration
  def change
    create_table :wardrobes do |t|
      t.integer :user_id
      t.string :authentication_token

      t.timestamps
    end
  end
end
