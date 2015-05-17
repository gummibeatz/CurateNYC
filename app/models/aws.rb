class Aws < ActiveRecord::Base
  def initialize(bucket_name, array, current, obj)
    @bucket_name = bucket_name
    @array = array
    @current = current
    @obj = obj
    @swipe_batch
    @newfolder
    @newbatch
    @newurl
  end

  def methods
    sort_bucket
    sort_swipe_batch
  end

  def access_bucket
    AWS::S3.new.buckets[@bucket_name]
  end

  def sort_bucket
    access_bucket.objects.each do |obj|
      if obj_is_swipe_batch?(obj)
        @swipe_batch = obj
      end
    end
  end

  def obj_is_swipe_batch?(obj)
    (obj.key =~ /swipe batches/) && (obj.key =~ /jpg/)
  end

  def sort_swipe_batch
    @newfolder = @swipe_batch.key.split("/")[1]
    @newbatch = @swipe_batch.key.split("/")[@swipe_batch.key.split("/").length-2]
    @newurl = "https://s3.amazonaws.com/curateanalytics/" + @swipe_batch.key.gsub('&', '%26').gsub('swipe ', 'swipe+')
  end
end