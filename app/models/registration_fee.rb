class RegistrationFee < ApplicationRecord
  belongs_to :event
  
  validates :name, presence: true 
  validates :registration_type, presence: true
  validates :amount, presence: true
end