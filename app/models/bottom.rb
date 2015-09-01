class Bottom < ActiveRecord::Base
  serialize :properties
  serialize :batch_information
  
  has_and_belongs_to_many :user

  attr_accessible :batch_information, :number, :file_name, :url, :properties
end
