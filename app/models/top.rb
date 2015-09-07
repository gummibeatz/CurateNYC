class Top < ActiveRecord::Base
  serialize :properties
  serialize :batch_information

  enum main_category: [:light_layer, :collared_shirt, :long_sleeve_shirt, :short_sleeve_shirt, :jacket]

  has_many :user_tops
  has_many :user, :through => :user_tops
  
  has_many :outfit_tops
  has_many :outfits, :through => :outfit_tops
  
  attr_accessible  :file_name, :url

  def self.create_with_data(data)
    top = Top.new
    top.file_name = data["File_Name"]
    top.save!
  end

end
