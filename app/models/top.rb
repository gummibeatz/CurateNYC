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
    top.file_name = data["file_name"]
    top.main_category = data["main_category"].gsub(" ","_")
    top.clothing_type = data["clothing_type"]
    top.collar_type = data["collar_type"]
    top.material = data["material"]
    top.brand = data["brand"]
    top.pattern = data["pattern"]
    top.color_1 = data["color_1"]
    top.color_2 = data["color_2"]
    top.spring = data["spring"]
    top.summer = data["summer"]
    top.fall = data["fall"]
    top.winter = data["winter"]
    top.warm = data["warm"]
    top.hot = data["hot"]
    top.brisk = data["brisk"]
    top.cold = data["cold"]
    top.casual = data["casual"]
    top.going_out = data["going_out"]
    top.dressy = data["dressy"]
    top.formal = data["formal"]
    top.first_layer = data["first_layer"]
    top.second_layer = data["second_layer"]
    top.third_layer = data["third_layer"]
    top.fourth_layer = data["fourth_layer"]
    top.priority = data["priority"]
    top.batch_number = data["batch_number"] 
    top.save!
  end

end
