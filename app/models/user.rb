class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :omniauth_providers => [:facebook]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :remember_me, :encrypted_password, :preferences
  
  has_many :user_tops
  has_many :tops, -> {distinct}, :through => :user_tops
  has_many :user_bottoms
  has_many :bottoms, -> {distinct}, :through => :user_bottoms
  has_many :outfits
  
  serialize :preferences
  before_save :ensure_authentication_token
  #after_save  :create_outfit, :create_like
 
  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth[:provider]
      user.uid = auth[:uid]
      user.name = auth[:info][:name]
      user.email = auth[:info][:email]
      user.password = Devise.friendly_token[0,20]
      user.image = auth[:info][:image]
      user.preferences = { height: nil, weight: nil, age: nil, waist_size: nil, inseam: nil, preferred_pants_fit: nil, shirt_size: nil, preferred_shirt_fit: nil, shoe_size: nil}
      user.save!
    end
  end
   
  private
  
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  provider               :string(255)
#  uid                    :string(255)
#  name                   :string(255)
#  email                  :string(255)
#  image                  :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  preferences            :text
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  authentication_token   :string(255)
#
