class Bottom < ActiveRecord::Base
  serialize :properties
  serialize :batch_information
  
  has_many :user, :through => users_bottoms
  belongs_to, :outfit
  
  attr_accessible :batch_information, :number, :file_name, :url, :properties
end
