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
    bottom.file_name = data["File_Name"]
    bottom.save!
  end

end
