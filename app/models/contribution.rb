class Contribution < ApplicationRecord
  belongs_to :backable, polymorphic: true
  belongs_to :user
  validates :amount, presence: true 
end
