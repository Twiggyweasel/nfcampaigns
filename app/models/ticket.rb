class Ticket < ApplicationRecord
  has_many :order_items
  has_many :sponsorships
  has_many :sponsor_levels
  belongs_to :event
  
  scope :is_available, -> { where(is_soldout: false, is_public: true) }
  scope :is_publick, -> { where(is_public: true)}
  
  
  after_find do
    update_sold    
    check_sold_out
  end
  
  def update_sold 
    self.update_column(:sold, self.order_items.pluck(:quantity).sum + self.sponsorships.where(paid: true).pluck(:quantity).sum) 
  end
  
  def check_sold_out
    if self.sold >= self.quantity
      self.update_column(:is_soldout, true)
    else
      self.update_column(:is_soldout, false)
    end
  end
  
end