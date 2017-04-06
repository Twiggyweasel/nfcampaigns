class SponsorLevel < ApplicationRecord
  belongs_to :ticket
  belongs_to :event
  
  validates :name, presence: true 
  # validates :desc, presence: true
  validates :quantity, presence: true 
  validates :price, presence: true
  
  
end