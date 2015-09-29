class Bottom < ActiveRecord::Base

  scope :priorities, -> { where(priority: true) }
  scope :in_batch_number, ->(number) { where(batch_number: number) }
  scope :with_colors, ->(colors) {where(color_1: colors)}

  enum main_category: [:pants, :shorts]
  
  has_many :user_bottoms
  has_many :users, -> {distinct}, :through => :user_bottoms
 
  validates :file_name, uniqueness: true

  belongs_to :outfit
  
  def self.create_with_data(data)
    bottom = Bottom.new
    bottom.file_name = data["file_name"]
    base_url = "https://s3.amazonaws.com/curateanalytics/swipe_batches/main/" 
    bottom.url = base_url + data["file_name"]
    bottom.main_category = data["main_category"]
    bottom.clothing_type = data["clothing_type"]
    bottom.clothing_type_2 = data["clothing_type_2"]
    bottom.pleat = data["pleat"]
    bottom.material = data["material"]
    bottom.brand = data["brand"]
    bottom.pattern = data["pattern"]
    bottom.color_1 = data["color_1"]
    bottom.color_2 = data["color_2"]
    bottom.spring = data["spring"] == "y"
    bottom.fall = data["summer"] == "y"
    bottom.winter = data["winter"] == "y"
    bottom.warm = data["warm"] == "y"
    bottom.hot = data["hot"] == "y"
    bottom.brisk = data["brisk"] == "y"
    bottom.cold = data["cold"] == "y"
    bottom.casual = data["casual"] == "y"
    bottom.going_out = data["going_out"] == "y"
    bottom.dressy = data["dress"] == "y"
    bottom.formal = data["formal"] == "y"
    bottom.priority = data["priority"] == "y"
    bottom.row_number = data["row_number"]
    bottom.save!
  end

end
