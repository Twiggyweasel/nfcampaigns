class Attendee < ApplicationRecord
  belongs_to :team
  belongs_to :event
  belongs_to :user
  
  has_one :pledge_page, dependent: :destroy
  has_many :contributions, as: :backable
  has_many :guests, inverse_of: :attendee
  has_many :payments, as: :payable
  accepts_nested_attributes_for :guests, allow_destroy: true, reject_if: :reject_guest
  
  mount_uploader :business_logo, EventCardUploader
  
  validates :fee, presence: true
  validates :shirt_size, presence: true
  validates :user_id, presence: true 
  validates :user_id, :uniqueness => { :scope => :event_id,
    :message => "You can only register to attend this event once!" }, if: "category == 'Personal'"
  
  scope :is_corporate, -> { where(category: 'Corporate') }
  scope :is_personal, -> { where(category: 'Personal') }
  after_create do
    self.create_pledge_page(goal: 1000, attendee_id: self.id)

  end
  
  after_save do 
    self.update_raised
    self.team.update_raised
  end
  
  def reject_guest(attributes)
    attributes['name'].blank?
  end
  
  def guests_fee_total
    Guest.where(attendee_id: self.id).pluck(:fee).sum
  end
  
  def attendee_total
    self.fee + guests_fee_total
  end
  
  def total_raised 
    if self.paid 
      self.contributions.where(paid: true).pluck(:amount).sum + attendee_total
    else
      self.contributions.where(paid: true).pluck(:amount).sum
    end
  end
  
  def update_raised
    
    self.update_column(:raised, total_raised)
  end
  
  def amount
    attendee_total
  end
  
  def processing_fee
    (self.attendee_total * 0.029) + 0.30
  end
  
  def name_w_description
    "#{name}" - "#{description}"
  end
end