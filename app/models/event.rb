class Event < ApplicationRecord
  has_many :contributions, as: :backable
  has_many :comments, as: :commentable
  has_many :teams
  has_many :attendees
  has_many :guests, through: :attendees
  has_many :registration_fees
  has_many :event_sizes
  has_many :sizes, through: :event_sizes
  has_many :resources
  mount_uploader :event_cover, EventCoverUploader
  mount_uploader :event_card, EventCardUploader
  
  validates :name, presence: true, length: {minimun: 5, maximum: 25 }
  validates :goal, presence: true
  validates :desc, presence: true 
  validates :event_type, presence: true 
  validates :venue_name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true
  validate :event_date_cannot_be_in_the_past
  validate :registration_date_cannot_be_after_event_date
  
  
  def event_date_cannot_be_in_the_past
    if event_date.present? && event_date < Date.today
      errors.add(:event_date, "can't be in the past")
    end
  end
  
  def registration_date_cannot_be_after_event_date
    if event_date.present? && registration_date.present? && registration_date > event_date
      errors.add(:registration_date, "can't be after the start of the event")
    end
  end
  
  after_find do 
    self.set_active
  end

  def all_attendees
    self.attendees.count + self.guests.count
  end
  
  def total_raised
    self.contributions.pluck(:amount).sum + team_total_raised
  end
  
  def team_total_raised
    
    self.teams.pluck(:raised).sum
  end
  
  def percent_raised
    if self.raised > 0
       (self.raised / self.goal) * 100
    end
  end
  
  after_create do 
    self.teams.create( name: "No Team", max_members: 999 , event_id: self.id)
    self.update_raised
  end
  
  after_save do
    self.update_raised    
  end
  
  def update_raised
      self.update_column(:raised, total_raised)
  end
  
  def set_active
    if self.registration_date.to_date.past? && self.is_private?
        self.update_column(:is_private, false)
    elsif self.registration_date.to_date.future? && !self.is_private?
        self.update_column(:is_private, true)
    end
  end
end
