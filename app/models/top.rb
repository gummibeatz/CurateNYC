class Top < ActiveRecord::Base

  scope :priorities, -> { where(priority: true) }
  scope :in_batch_number, ->(number) { where(batch_number: number) }

  enum main_category: [:light_layer, :collared_shirt, :long_sleeve_shirt, :short_sleeve_shirt, :jacket]

  has_many :user_tops
  has_many :user, :through => :user_tops
  
  has_many :outfit_tops
  has_many :outfits, :through => :outfit_tops
  
  def self.create_with_data(data)
    top = Top.new
    top.file_name = data["file_name"]
    base_url = "https://s3.amazonaws.com/curateanalytics/swipe_batches/main/" 
    top.url = base_url + data["file_name"]
    top.main_category = data["main_category"].gsub(" ","_")
    top.clothing_type = data["clothing_type"]
    top.collar_type = data["collar_type"]
    top.material = data["material"]
    top.brand = data["brand"]
    top.pattern = data["pattern"]
    top.color_1 = data["color_1"]
    top.color_2 = data["color_2"]
    top.spring = data["spring"] == "y"
    top.summer = data["summer"] == "y"
    top.fall = data["fall"] == "y"
    top.winter = data["winter"] == "y"
    top.warm = data["warm"] == "y"
    top.hot = data["hot"] == "y"
    top.brisk = data["brisk"] == "y"
    top.cold = data["cold"] == "y"
    top.casual = data["casual"] == "y"
    top.going_out = data["going_out"] == "y"
    top.dressy = data["dressy"] == "y"
    top.formal = data["formal"] == "y"
    top.first_layer = data["first_layer"] == "y"
    top.second_layer = data["second_layer"] == "y"
    top.third_layer = data["third_layer"] == "y"
    top.fourth_layer = data["fourth_layer"] == "y"
    top.priority = data["priority"] == "y"
    top.batch_number = data["batch_number"] == "y" 
    top.save!
  end

end
