class Order < ApplicationRecord
  has_many :order_items, inverse_of: :order, dependent: :destroy
  has_many :payments, as: :payable
  belongs_to :event
  belongs_to :user

  accepts_nested_attributes_for :order_items

  scope :expiring, -> { where('created_at > ?', 24.hours.ago).where(paid: false) }
  def amount
    amount = 0
    self.order_items.each do |item|
      amount = amount + item.total
    end
    return amount
  end

  def processing_fee
    (self.order_total * 0.029) + 0.30
  end

  def unpaid_amount
  amount = 0
    self.order_items.each do |item|
      amount = amount + item.total
    end
    return amount
  end

end