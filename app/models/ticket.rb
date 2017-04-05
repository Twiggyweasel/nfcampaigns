class Ticket < ApplicationRecord
  has_many :order_items
  has_many :sponsorships
  has_many :sponsor_levels
  belongs_to :event
  
  scope :not_soldout, -> { where(is_soldout: false) }
  
  after_find do
    update_sold    
    check_sold_out
  end
  
  def update_sold 
    self.update_column(:sold, self.order_items.pluck(:quantity).sum)
  end
  
  def total_tickets_sold_to_sponsors
    self.update_column(:sold, self.sponsorships.pluck(:quantity).sum)
  end
  
  def check_sold_out
    if self.sold >= self.quantity
      self.update_column(:is_soldout, true)
    else
      self.update_column(:is_soldout, false)
    end
  end
  
end