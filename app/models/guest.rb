class Guest < ApplicationRecord
  belongs_to :attendee
  has_one :event, through: :attendee
  
  validates :fee, presence: true 
  
  scope :is_paid, -> { where(paid: true) }
end