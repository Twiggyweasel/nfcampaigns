class Contribution < ApplicationRecord
  belongs_to :backable, polymorphic: true
  
  validates :amount, presence: true 
end
