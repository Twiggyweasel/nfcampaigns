class Profile < ApplicationRecord
  belongs_to :user 
  
  validates_uniqueness_of :user_id, :message => "You can only create one profile"
  
end