class Event < ApplicationRecord
  has_many :contributions, as: :backable
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :attendees
  has_many :guests, through: :attendees
  has_many :registration_fees, dependent: :destroy
  has_many :event_sizes
  has_many :sizes, through: :event_sizes
  has_many :resources, dependent: :destroy
  has_one :promo_card 
  
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
  validates :event_start_time, presence: true
  validates :event_end_time, presence: true
  validates :registration_date, presence: true
  validates :event_date, presence: true
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
    self.registration_fees.create(name: "Adult: 12 and over", category: "Personal", amount: 25.00, guest_limit: 99)
    self.registration_fees.create(name: "Child: 4 to 11", category: "Personal", amount: 12.00, guest_limit: 99)
    self.registration_fees.create(name: "Child: 3 and under", category: "Personal", amount: 6.00, guest_limit: 99)    
    self.registration_fees.create(name: "Mile Marker Sponsor", category: "Corporate", amount: 250.00, guest_limit: 0, description: "Employees distribute water and/or name on
mile marker sign, name on local T-shirts and event website")    
    self.registration_fees.create(name: "Hometown Sponsor", category: "Corporate", amount: 500.00, guest_limit: 5, description: "Five free walkers from your business,
name on local T-shirt and event website")
    self.registration_fees.create(name: "Silver Sponsor", category: "Corporate", amount: 1000.00, guest_limit: 10, description: "Company name announced at award ceremony, 10 free walkers from your business,
name on the NF banner at the award presentation, name on local T-shirt and event website")    
    self.registration_fees.create(name: "Gold Sponsor", category: "Corporate", amount: 2500.00, guest_limit: 25, description: "Framed certificate presented at the award ceremony, 25 free walkers from your business, name on the NF banner at the award Presentation
name on nationwide T-shirt & event websites")
    self.registration_fees.create(name: "Platinum Sponsor", category: "Corporate", amount: 5000.00, guest_limit: 50, description: "Name on the NF Network national website, plaque presented at the award ceremony, 50 free walkers from your business, name on the NF banner at the award presentation, name on nationwide T-shirts and event websites")
    self.update_raised
    self.resources.create(name: "NF Network Brochure", remote_attachment_url: "https://s3.amazonaws.com/nfeventimages/documents/NF+Network+Brochure.pdf")
    self.resources.create(name: "Fundraising Sample Letter", remote_attachment_url: "https://s3.amazonaws.com/nfeventimages/documents/Personal+Story-NF+Hero+Letter.pdf")
    self.resources.create(name: "Donor Form", remote_attachment_url: "https://s3.amazonaws.com/nfeventimages/documents/GS4NF+Donor+Form.pdf")
    self.resources.create(name: "NF Network Pledge Sheet", remote_attachment_url: "https://s3.amazonaws.com/nfeventimages/documents/Great+Steps+Pledge+Sheet.pdf")
    self.resources.create(name: "Fundraising Ideas A-Z", remote_attachment_url: "https://s3.amazonaws.com/nfeventimages/documents/Fundraising+A-Z.pdf")
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

class NilClass
  def to_date
    Date.today
  end
end