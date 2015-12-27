class UserTop < ActiveRecord::Base
  belongs_to :user
  belongs_to :top
end

# == Schema Information
#
# Table name: user_tops
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  top_id     :integer
#  created_at :datetime
#  updated_at :datetime
#
