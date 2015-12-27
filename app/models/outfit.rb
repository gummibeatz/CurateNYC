class Outfit < ActiveRecord::Base
  belongs_to :user, :dependent => :destroy
  
  has_many :outfit_tops
  has_many :tops, :through => :outfit_tops
  has_one :bottom

  serialize :outfits
  after_create :serialize_outfits
  
  def serialize_outfits
    self.user_id = user.id
    self.authentication_token = user.authentication_token
    self.save!
  end
end

# == Schema Information
#
# Table name: outfits
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  authentication_token :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#
