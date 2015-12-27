FactoryGirl.define do
  factory :email do
    email "MyString"
  end

end

# == Schema Information
#
# Table name: emails
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#
