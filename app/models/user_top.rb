class UserTop < ActiveRecord::Base
  belongs_to :user
  belongs_to :top
end
