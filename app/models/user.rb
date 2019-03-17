class User < ApplicationRecord
  validates_presence_of :email
  validates_presence_of :password, require: true
  
  has_secure_password
  
  has_many :favorites, dependent: :destroy
  
  before_create :set_api_key
  
  private
  
  def set_api_key
    self.api_key = SecureRandom.hex(14)
  end
end

