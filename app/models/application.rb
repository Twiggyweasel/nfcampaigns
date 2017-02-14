class Application < ApplicationRecord 
  validates :name, presence: true, length: { minimum: 6 }
  validates :email, presence: true
  validates :phone, presence: true, length: { is: 10 }
end