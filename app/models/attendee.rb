class Attendee < ApplicationRecord
  belongs_to :team
  belongs_to :event
  belongs_to :user
  
  has_one :pledge_page
  has_many :contributions, as: :backable
  has_many :guests, inverse_of: :attendee
  
  accepts_nested_attributes_for :guests, allow_destroy: true, reject_if: :reject_guest
  
  validates :fee, presence: true
  validates :shirt_size, presence: true
  validates :user_id, presence: true, :uniqueness => { :scope => :event_id,
    :message => "You can only register to attend this event once!" }
  
  def reject_guest(attributes)
    attributes['name'].blank?
  end
  
  def total_raised 
    self.contributions.pluck(:amount).sum + attendee_total
  end
  def guests_fee_total
    Guest.where(attendee_id: self.id).pluck(:fee).sum
  end
  
  def attendee_total
    self.fee + guests_fee_total
  end
  
end