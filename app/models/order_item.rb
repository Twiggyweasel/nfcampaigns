class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :ticket
  
  validates :quantity, presence: true
  
  def total
    self.quantity * self.ticket.fee
  end
  
end