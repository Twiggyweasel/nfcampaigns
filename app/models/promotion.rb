class Promotion < ApplicationRecord
  has_many :promo_cards
  attr_accessor :attendee_id
  
  validates :discount, presence: true
  validates :code, presence: true
  validates :stop, presence: true
  validates :start, presence: true
after_find do 
  # if self.stop < Time.now
  #   self.update_column(:is_active, false)
  # elsif !self.is_active && self.stop > Time.now
  #   self.update_column(:is_active, true)
  # end
end
  
  
  
class Float
  def floor2(exp = 0)
   multiplier = 10 ** exp
   ((self * multiplier).floor).to_f/multiplier.to_f
  end
end
end