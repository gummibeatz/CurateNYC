class Bottoms < ActiveRecord::Base
  serialize :properties
  belongs_to :batch
  attr_accessible :batch_folder, :batch_number, :file_name, :url, :properties
end