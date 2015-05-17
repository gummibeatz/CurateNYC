# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
Rails.application.load_tasks

dbArray = JSON.parse(File.read(File.join(Rails.root, 'public', 'DatabaseArray.json'))) 

desc "Read AWS" 
task :read_aws => :environment do
  Tops.connection
  createClothesInSQLWithDatabase(dbArray)
  addBatchAndURLInformation()
end


def createClothesInSQLWithDatabase(dbArray) 
  dbArray.each do |main_category|
    main_category.each do |obj|
      clothing = JSON.parse(obj)
      Tops.create({
        batch_information: [], 
        file_name: clothing["File_Name"], 
        url: clothing[""],
        properties: formatHashKeys(clothing["Properties"])
      })
    end
    #only gonna do tops for now tkae out break later
    # break
  end
end

# Adds in batch information based on AWS buckets
def addBatchAndURLInformation()
  AWS::S3.new.buckets['curateanalytics'].objects.each do |obj|
    if(obj.key =~ /swipe batches/) && (obj.key =~ /jpg/)
      folder = obj.key.split("/")[1]
      batch = obj.key.split("/")[obj.key.split("/").length-2]
          url = "https://s3.amazonaws.com/curateanalytics/" + obj.key.gsub('&', '%26').gsub('swipe ', 'swipe+')
          filename = obj.key.split("/").last
          array = [folder, batch]

          if Tops.exists?(file_name: filename)
            @top = Tops.find_by file_name: filename
            @top.url = url
            @top.batch_information << array
            @top.save!
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