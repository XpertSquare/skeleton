class Registration < ApplicationRecord
  validates_presence_of :name, :email, :business_name , :on => :create
  
  
end
