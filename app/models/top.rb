class Top < ActiveRecord::Base
  serialize :properties
  serialize :batch_information

  has_many :user_tops
  has_many :user, :through => :user_tops
  
  has_many :outfit_tops
  has_many :outfits, :through => :outfit_tops
  
  attr_accessible :batch_information, :number, :file_name, :url, :properties
end
