class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :ticket
  
  validates :quantity, presence: true
  
  scope :has_quant, -> { where("quantity > ?", 0 )}
  
  def total
    self.quantity * self.ticket.fee
  end
  
end