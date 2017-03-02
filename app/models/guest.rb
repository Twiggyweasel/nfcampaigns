class Guest < ApplicationRecord
  belongs_to :attendee
  has_one :event, through: :attendee
  
  validates :fee, presence: true 
end