class Contribution < ApplicationRecord
  belongs_to :backable, polymorphic: true
  has_many :payments, as: :payable
  belongs_to :user
  validates :amount, presence: true 
  
  after_create do
    self.backable.update_raised
  end
end
