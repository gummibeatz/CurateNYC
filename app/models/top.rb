class Top < ActiveRecord::Base
  serialize :properties
  serialize :batch_information

  has_many :user, :through => users_tops
  has_many :outfit, :through => users_outfits
  
  attr_accessible :batch_information, :number, :file_name, :url, :properties
end
