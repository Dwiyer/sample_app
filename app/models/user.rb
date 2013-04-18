# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, 
		:remember_token
  has_secure_password #what's the meaning?
  has_many :microposts#, dependent: :destroy #The name of model.
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
		format: { with: VALID_EMAIL_REGEX },
		uniqueness: { case_sensetive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

#  def admin?
#    self.admin
#  end
  def feed
    Micropost.where("user_id=?",id)
  end
  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64#Create the token
  end
  
end
