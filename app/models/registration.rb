class Registration < ApplicationRecord
  validates_presence_of :name, :email, :business_name , :on => :create
  
  before_create  { generate_token(:token) }
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64(32)
    end while Registration.exists?(column => self[column])
  end
end
