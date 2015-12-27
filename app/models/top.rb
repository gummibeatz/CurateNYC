class Top < ActiveRecord::Base

  scope :priorities, -> { where(priority: true) }
  scope :in_batch_number, ->(number) { where(batch_number: number) }
  scope :with_colors, ->(colors) {where(color_1: colors)}
  scope :with_colors_and_layer_1, ->(colors) {where(color_1: colors).where(first_layer: true)}
  scope :with_colors_and_layer_2, ->(colors) {where(color_1: colors).where(second_layer: true)}

  enum main_category: [:light_layer, :collared_shirt, :long_sleeve_shirt, :short_sleeve_shirt, :jacket]

  has_many :user_tops
  has_many :user, -> {distinct}, :through => :user_tops
  
  has_many :outfit_tops
  has_many :outfits, :through => :outfit_tops

  validates :file_name, uniqueness: true
  
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
    top.row_number = data["row_number"] 
    top.save!
  end

end

# == Schema Information
#
# Table name: tops
#
#  id            :integer          not null, primary key
#  url           :string(255)
#  file_name     :string(255)
#  main_category :integer          default(0)
#  clothing_type :string(255)
#  collar_type   :string(255)
#  material      :string(255)
#  brand         :string(255)
#  pattern       :string(255)
#  color_1       :string(255)
#  color_2       :string(255)
#  spring        :boolean
#  summer        :boolean
#  fall          :boolean
#  winter        :boolean
#  warm          :boolean
#  hot           :boolean
#  brisk         :boolean
#  cold          :boolean
#  casual        :boolean
#  going_out     :boolean
#  dressy        :boolean
#  formal        :boolean
#  first_layer   :boolean
#  second_layer  :boolean
#  third_layer   :boolean
#  fourth_layer  :boolean
#  priority      :boolean
#  row_number    :integer
#  created_at    :datetime
#  updated_at    :datetime
#
