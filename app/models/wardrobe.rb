class Wardrobe < ActiveRecord::Base
  belongs_to :user
  serialize :wardrobe
  after_create :serialize_wardrobe

  def serialize_wardrobe
    self.user_id = user.id
    self.authentication_token = user.authentication_token
    self.wardrobe = {:tops => [{:file_name => "",
      :url => "https://s3.amazonaws.com/curateanalytics/tops/hoodie/H%26M.Hoodie.Burgundy.jpg",
      :properties => {}
     },{:file_name => "",
      :url => "https://s3.amazonaws.com/curateanalytics/tops/hoodie/H%26M.Hoodie.Charcoal.jpg",
      :properties => {}
     },{:file_name => "",
      :url => "https://s3.amazonaws.com/curateanalytics/tops/shirt/collared/chambray/slim/Uniqlo.Chambray.Slim.Printed.Blue.jpg",
      :properties => {}
     },{:file_name => "",
      :url => "https://s3.amazonaws.com/curateanalytics/tops/shirt/collared/chambray/slim/Uniqlo.Chambray.Slim.Printed.Gray.jpg",
      :properties => {}
     }],
     :bottoms => [{:file_name => "",
      :url => "http://s3.amazonaws.com/curateanalytics/bottoms/pants/5pocket%20pants/regular/H&M_5-Pocket_Regular_Black.jpg",
      :properties => {}
     },{:file_name => "",
      :url => "http://s3.amazonaws.com/curateanalytics/bottoms/pants/5pocket%20pants/regular/H&M_5-Pocket_Regular_Blue.jpg",
      :properties => {}
     }]}
     # Properties.new(self.wardrobe).find_properties
     find_properties
    self.save!
  end

  # class Properties
  #   def initialize(wardrobe)
  #     @hash = {}
  #     @wardrobe = wardrobe
  #   end

  #   def find_properties
  #     read_json
  #     parse_json
  #     parse_main
  #     parse_sub
  #     return @hash
  #   end

  #   def read_json
  #     @json = JSON.parse(File.read(File.join(Rails.root, 'public', 'DatabaseArray.json')))
  #   end

  #   def parse_json
  #     @json.each do |main|
  #       @main = main
  #     end
  #   end

  #   def parse_main
  #     @main.each do |sub|
  #       @sub = sub
  #     end
  #   end

  #   def parse_sub
  #     @sub.gsub("\"","")[1..-2].split(",").each do |properties|
  #       @property = properties.split(":")
  #       parse_wardrobe
  #     end
  #   end

  #   def parse_wardrobe
  #     @wardrobe.keys.each do |key|
  #       @key = key
  #       parse_keys
  #     end
  #   end

  #   def parse_keys
  #     @wardrobe[@key].each do |files|
  #       @files = files
  #       add_property
  #     end
  #   end

  #   def add_property
  #     if property_is_filename?
  #       if is_part_of_wardrobe?

  #       end
  #     end
  #   end

  #   def property_is_filename?
  #     @property.first == "File_Name"
  #   end

  #   def is_part_of_wardrobe?
  #     @property.second == @files[:url].split("/").last.gsub("%26","&")
  #   end
  # end
  def find_properties
    s = File.join(Rails.root, 'public', 'DatabaseArray.json')
    file = File.read(s)
    data_hash = JSON.parse(file)
    data_hash.each do |main_category|
      main_category.each do |sub_category|
        self.wardrobe.keys.each do |key|
          self.wardrobe[key].each do |files|
            @wardrobe_url = files[:url].split("/").last.gsub("%26","&")
            if (@wardrobe_url == sub_category.split(",").first.split(":").second.split("\"").second)
              sub_category.gsub("\"","")[1..-2].split(",").each do |string|
                properties = string.split(":")
                if (properties.first == "Properties")
                  files[:properties].merge!(properties.second.gsub!("{","").parameterize.underscore.to_sym => properties.last)
                elsif (properties.first == "File_Name")
                  files[:file_name] = properties.second
                elsif (properties.first != "URL")
                  files[:properties].merge!(properties.first.parameterize.underscore.to_sym => properties.second)
                end
              end
            end
          end
        end
      end  
    end
  end
end