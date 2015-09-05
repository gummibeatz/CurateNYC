class Outfit < ActiveRecord::Base
  belongs_to :user, :dependent => :destroy
  has_many :tops
  has_one :bottom

  serialize :outfits
  after_create :serialize_outfits
  
  def serialize_outfits
    self.user_id = user.id
    self.authentication_token = user.authentication_token
    self.outfits = [{:title => "outfit_0 title", :tag => ["tag_0", "tag_1", "tag_2"],:items => {:top => "url", :bottoms => "url"}}]
    self.save!
  end
end
