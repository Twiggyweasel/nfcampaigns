class Attendee < ApplicationRecord
  belongs_to :team
  belongs_to :event
  belongs_to :user
  
  has_one :pledge_page, dependent: :destroy
  has_many :contributions, as: :backable
  has_many :guests, inverse_of: :attendee, dependent: :destroy
  has_many :payments, as: :payable
  accepts_nested_attributes_for :guests, allow_destroy: true, reject_if: :reject_guest
  
  mount_uploader :business_logo, EventCardUploader
  
  validates :fee, presence: true
  validates :shirt_size, presence: true
  validates :user_id, presence: true 
  validates_inclusion_of :accepted_terms, :in => [true], :message => "You must accept the terms before you can register for this event"
  validates :user_id, :uniqueness => { :scope => :event_id,
    :message => "You can only register to attend this event once!" }, if: "category == 'Personal'", on: create
  
  scope :is_corporate, -> { where(category: 'Corporate') }
  scope :is_personal, -> { where(category: 'Personal') }
  scope :is_new_2_hours, -> { where(created_at: (Time.now - 2.hours)..Time.now) }
  
  after_create do
    self.create_pledge_page(goal: 1000, attendee_id: self.id)

  end
  
  after_save do 
    self.update_raised
    self.team.update_raised
    self.check_guest_limit
  end
  
  after_find do 
    self.update_raised
  end
  
  def check_guest_limit
    if self.guest_limit.nil?
      self.update_column(:guest_limit, 99)
    end
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
  
  def unpaid_amount
    if self.paid
      guests_unpaid_total
    else
      guests_unpaid_total + self.fee 
    end
  end
  
  def guests_unpaid_total
    Guest.where(attendee_id: self.id, paid: false).pluck(:fee).sum
  end
  
  def processing_fee
    (self.attendee_total * 0.029) + 0.30
  end
  
  def name_w_description
    "#{name}" - "#{description}"
  end
end