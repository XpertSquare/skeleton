class Account < ApplicationRecord
  has_many :memberships
  has_many :users, :through => :memberships, :dependent => :destroy
 
  validates_presence_of :name
  validates_format_of :subdomain, :with => /^[A-Za-z0-9-]+$/, :multiline => true, :message => 'The subdomain can only contain alphanumeric characters and dashes.', :allow_blank => true
  validates_uniqueness_of :subdomain, :case_sensitive => false
  #validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.all(&:name), :if => :time_zone
 
 
 before_validation :downcase_subdomain

 RESERVED_SUBDOMAINS = %w(support blog www billing help api admin en fr ro it es de hu).freeze
  
  
 def self.is_reserved_subdomain(subdomain)
   RESERVED_SUBDOMAINS.include? subdomain
 end  
 
 def self.current_id=(id)
    Thread.current[:account_id] = id
  end
    
  def self.current_id
    Thread.current[:account_id]
  end
 
 protected

 def downcase_subdomain
   self.subdomain.downcase! if attribute_present?("subdomain")
 end
 
  
end
