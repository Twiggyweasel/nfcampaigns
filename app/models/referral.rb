class Referral < ApplicationRecord
  belongs_to :user
  belongs_to :team 
  
  has_one :event, through: :team 
  
end