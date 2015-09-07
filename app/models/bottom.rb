class Bottom < ActiveRecord::Base
  serialize :properties
  serialize :batch_information

  enum main_category: [:pants, :shorts]
  
  has_many :user_bottoms
  has_many :users, :through => :user_bottoms
  
  belongs_to :outfit
  
  attr_accessible :file_name, :url

  def self.create_with_data(data)
    bottom = Bottom.new
    bottom.file_name = data["file_name"]
    bottom.main_category = data["main_category"]
    bottom.clothing_type = data["clothing_type"]
    bottom.clothing_type_2 = data["clothing_type_2"]
    bottom.pleat = data["pleat"]
    bottom.material = data["material"]
    bottom.brand = data["brand"]
    bottom.pattern = data["pattern"]
    bottom.color_1 = data["color_1"]
    bottom.color_2 = data["color_2"]
    bottom.spring = data["spring"]
    bottom.fall = data["summer"]
    bottom.winter = data["winter"]
    bottom.warm = data["warm"]
    bottom.hot = data["hot"]
    bottom.brisk = data["brisk"]
    bottom.cold = data["cold"]
    bottom.casual = data["casual"]
    bottom.going_out = data["going_out"]
    bottom.dressy = data["dress"]
    bottom.formal = data["formal"]
    bottom.priority = data["priority"]
    bottom.batch_number = data["batch_number"]
    bottom.save!
  end

end
