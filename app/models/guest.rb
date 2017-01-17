class Guest < ApplicationRecord
  belongs_to :attendee
  has_one :event, through: :attendee
  
end