class Application < ApplicationRecord 
  validates :name, presence: true, length: { minimum: 6 }
  validates :email, presence: true
  validates :phone, presence: true
  validates :event_type, presence: true
  validates :city, presence: true
  validates :state, presence: true
end