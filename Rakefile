# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
Rails.application.load_tasks

desc "Read AWS" 
task :read_aws => :environment do
  Tops.connection
  @hash = {}
  AWS::S3.new.buckets['curateanalytics'].objects.each do |obj|
    if (obj.key =~ /swipe batches/) && (obj.key =~ /jpg/)
      @newfolder = obj.key.split("/")[1]
      @newbatch = obj.key.split("/")[obj.key.split("/").length-2]
      @newurl = "https://s3.amazonaws.com/curateanalytics/" + obj.key.gsub('&', '%26').gsub('swipe ', 'swipe+')
      @filename = obj.key.split("/").last
      @array = [@newfolder, @newbatch]
      JSON.parse(File.read(File.join(Rails.root, 'public', 'DatabaseArray.json'))).each do |main|
        main.each do |sub|
          if sub.split("\"")[3] == obj.key.split("/").last
            sub.gsub("\"","")[1..-2].split(",").each do |properties|
              @property = properties.split(":")
              if @property.first == "URL"
                @hash.merge!(@property.first.parameterize.underscore.to_sym => @property.last)
              elsif @property.first == "File_Name"
                @hash.merge!(@property.first.parameterize.underscore.to_sym => @property.last)
              elsif @property.second == "{Main_Category"
                @hash.merge!(@property.second.parameterize.underscore.to_sym => @property.last)
              else
                @hash.merge!(@property.first.parameterize.underscore.to_sym => @property.last)
              end
            end
            if Tops.where(file_name: @filename) == []
              @number = @newbatch[-2..-1].to_i
              Tops.create({:batch_information => [@array], :number => @number, :file_name => @newurl.split("/").last.gsub("%26","&"), :url => @newurl, :properties => @hash})
            elsif !Tops.where(file_name: @filename).first.batch_information.include?(@array)
              @top = Tops.where(file_name: @filename).first
              @top.batch_information << @array
              @top.save!
            end
          else
            next
          end
        end
      end
    end
  end
end