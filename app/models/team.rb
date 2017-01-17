class Team < ApplicationRecord
  belongs_to :event
  has_many :contributions, as: :backable
  has_many :attendees, inverse_of: :team
  
  accepts_nested_attributes_for :attendees, allow_destroy: true
  
  validates :name, presence: true
end
