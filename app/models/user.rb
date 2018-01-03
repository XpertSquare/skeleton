class User < ApplicationRecord
  has_secure_password
  has_many :memberships
  has_many :accounts, :through => :memberships, :dependent => :destroy
  
  attr_accesible :username, :email, :display_name, :password, :password_confirmation
  
  
  before_create  { generate_token(:auth_token) }
  
  after_validation { self.errors.messages.delete(:password_digest) }
    
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  def generate_password
     @char_map =  [('a'..'z'),('A'..'Z'), (0..9)].map{|i| i.to_a}.flatten
     self.password = (0...10).map{ @char_map[rand(@char_map.length)] }.join
  end
  
  
  
end
