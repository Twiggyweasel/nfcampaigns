class RegistrationFee < ApplicationRecord
  belongs_to :event
  
  validates :name, presence: true 
  validates :category, presence: true
  validates :amount, presence: true
  
  scope :is_corporate, -> { where(category: 'Corporate') }
  scope :is_personal, -> { where(category: 'Personal') }
end