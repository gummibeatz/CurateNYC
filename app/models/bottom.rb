class Bottom < ActiveRecord::Base
  serialize :properties
  serialize :batch_information

  enum main_category: [:pants, :shorts]
  
  has_many :user_bottoms
  has_many :users, :through => :user_bottoms
  
  belongs_to :outfit
  
  attr_accessible :batch_information, :number, :file_name, :url, :properties
end
