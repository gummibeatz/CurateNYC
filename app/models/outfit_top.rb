class OutfitTop < ActiveRecord::Base
  belongs_to :outfit
  belongs_to :top
end

# == Schema Information
#
# Table name: outfit_tops
#
#  id         :integer          not null, primary key
#  outfit_id  :integer
#  top_id     :integer
#  created_at :datetime
#  updated_at :datetime
#
