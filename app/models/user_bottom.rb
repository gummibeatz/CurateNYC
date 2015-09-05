class UserBottom < ActiveRecord::Base
  belongs_to :bottom
  belongs_to :top
end
