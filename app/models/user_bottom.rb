class UserBottom < ActiveRecord::Base
  belongs_to :bottom
  belongs_to :top
end

# == Schema Information
#
# Table name: user_bottoms
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  bottom_id  :integer
#  created_at :datetime
#  updated_at :datetime
#
