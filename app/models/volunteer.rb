class Volunteer < ApplicationRecord
  belongs_to :event

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :street1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true
  validates :email, presence: true
  validates :shirt_size, presence: true
  validates :event_id, presence: true

  def full_name
    self.first_name + " " + self.last_name
  end
end