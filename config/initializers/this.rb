class This
  require "pry"
  def initialize
    AwsAccess.new('curateanalytics', [], "", {}).sort_through_bucket
  end
  module AwsAccess
    def initialize(bucket_name, array, current, obj)
      @bucket_name = bucket_name
      @array = array
      @current = current
      @obj = obj
      @newfolder
      @newbatch
      @newurl
    end

    def access_bucket
      return AWS::S3.new.buckets[@bucket_name]
    end

    def sort_through_bucket
      access_bucket.objects.each do |obj|
        if obj_is_swipe_batch?(obj)
          create_new_instances(obj)
          if !obj_contains_key?
            add_newfolder_key
          end
          if !current_equals_batch?
            @current = @newbatch
            if array_not_array?
              @obj[@newfolder] << @array
            end
          end
          if Properties.new(@newurl).find_properties[:main_category] == "Bottoms"
            return @bottom = Bottoms.create({:batch_folder => @newfolder, :batch_number => @newbatch , :file_name => @newurl.split("/").last.gsub("%26","&"), :url => @newurl, :properties => Properties.new(@newurl).find_properties})
          end
          if Properties.new(@newurl).find_properties[:main_category] == "Tops"
            @top = Tops.create({:batch_folder => @newfolder, :batch_number => @newbatch, :file_name => @newurl.split("/").last.gsub("%26","&"), :url => @newurl, :properties => Properties.new(@newurl).find_properties})
          end
        end
      end
    end

    def obj_is_swipe_batch?(obj)
      return ((obj.key =~ /swipe batches/) && (obj.key =~ /jpg/))
    end

    def create_new_instances(obj)
      @newfolder = obj.key.split("/")[1]
      @newbatch = obj.key.split("/")[obj.key.split("/").length-2]
      @newurl = "https://s3.amazonaws.com/curateanalytics/" + obj.key.gsub('&', '%26').gsub('swipe ', 'swipe+')
    end

    def obj_contains_key?
      @obj.key?(@newfolder)
    end

    def add_newfolder_key
      @obj.merge!(@newfolder => [])
    end

    def current_equals_batch?
      @current == @newbatch
    end

    def array_not_array?
      @array != []
    end
  end

  module Properties
    def initialize(bucket_url)
      @bucket_url = bucket_url
      @hash = {}
    end

    def find_properties
      read_json
      parse_json
      parse_main
      parse_sub
      return @hash
    end

    def read_json
      @json = JSON.parse(File.read(File.join(Rails.root, 'public', 'DatabaseArray.json')))
    end

    def parse_json
      @json.each do |main|
        @main = main
      end
    end

    def parse_main
      @main.each do |sub|
        @sub = sub
      end
    end

    def parse_sub
      @sub.gsub("\"","")[1..-2].split(",").each do |properties|
        @property = properties.split(":")
        is_everything
      end
    end

    def is_URL?
      @property.first == "URL"
    end

    def is_File_Name?
      @property.first == "File_Name"
    end

    def is_Main?
      @property.second == "{Main_Category"
    end

    def is_everything
      if !is_URL? && !is_File_Name? && is_Main?
        hash_merge(@property.second.gsub!("{",""),@property.last)
      elsif !is_URL? && !is_File_Name?
        hash_merge(@property.first,@property.last)
      end
    end

    def hash_merge(name, property)
      @hash.merge!(name.parameterize.underscore.to_sym => property)
    end
  end
end