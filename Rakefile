# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
require 'set'
require File.expand_path('../config/application', __FILE__)
Rails.application.load_tasks

dbArray = JSON.parse(File.read(File.join(Rails.root, 'public', 'DatabaseArray.json'))) 

desc "Adds Tops and Bottoms to their respective tables based on dbArray file" 
task :update_tops_and_bottoms => :environment do
  Top.connection
  Bottom.connection 
  createClothesInSQLWithDatabase(dbArray)
  addBatchAndURLInformation()
end

desc "Check AWS"
task :check_aws => :environment do
  Top.connection
  Bottom.connection 
  addBatchAndURLInformation(true)
end


def createClothesInSQLWithDatabase(dbArray) 
  dbArray.each_with_index do |main_category, index|
    main_category.each do |obj|
      clothing = JSON.parse(obj)
      # checks to see if clothing exists before adding
      case index
      when 0
        if !Top.exists?(:file_name => clothing["File_Name"])
          Top.create!({
              batch_information: [],
            number: 0,
            file_name: clothing["File_Name"],
            url: "",
            properties: formatHashKeys(clothing["Properties"])
          })
        end
      when 1
        if !Bottom.exists?(:file_name => clothing["File_Name"])
          Bottoms.create({
              batch_information: [],
            number: 0,
            file_name: clothing["File_Name"],
            url: "",
            properties: formatHashKeys(clothing["Properties"])
          })           
        end
      end
    end
  end
end

# Adds in batch information based on AWS buckets
def addBatchAndURLInformation(shouldTest = false)
  missingitems = Set.new
  AWS::S3.new.buckets['curateanalytics'].objects.each do |obj|
    if(obj.key =~ /swipe batches/) && (obj.key =~ /jpg/)
      folder = obj.key.split("/")[1]
      batch = obj.key.split("/")[obj.key.split("/").length-2]
      url = "https://s3.amazonaws.com/curateanalytics/" + obj.key.gsub('&', '%26').gsub('swipe ', 'swipe+')
      filename = obj.key.split("/").last
      array = [folder, batch]
      number = batch.split('_')[1].to_i
      if (!Clothing.exists?(file_name: filename) && shouldTest == true)
        missingitems.add(filename)
      elsif Clothing.exists?(file_name: filename)
        @piece = Clothing.find_by file_name: filename
        @piece.url = url
        @piece.number = number
        @piece.batch_information << array
        @piece.save!
      end
    end
  end
  if shouldTest == true
    File.open("missingClothes.txt", 'w') do |f|
      missingitems.each do |item|
        f.puts(item)
      end
    end
  end
end

# makes hash keys lowercase
def formatHashKeys(hash)
  new_hash = {}
  hash.each_pair do |k,v|
    new_hash["#{k.downcase}"] = v
  end 
  return new_hash
end
