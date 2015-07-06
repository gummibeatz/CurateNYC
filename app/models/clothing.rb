class Clothing < ActiveRecord::Base
  serialize :properties
  serialize :batch_information
  belongs_to :batch
  attr_accessible :batch_information, :number, :file_name, :url, :properties
end