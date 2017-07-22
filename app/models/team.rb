class Team < ApplicationRecord
  belongs_to :event
  has_one :leader,-> { where(is_leader: true, team_id: self) }, :class_name => "Attendee"
  # has_many :contributions, as: :backable
  has_many :attendees, -> { order(:name) }, inverse_of: :team
  has_many :contributions, through: :attendees
  mount_uploader :team_photo, ChampionImageUploader

  accepts_nested_attributes_for :attendees, allow_destroy: true

  validates :name, presence: true
  validates_uniqueness_of :name, conditions: -> { where.not(name: 'No Team') }

  after_find do
    # if Contribution.where(backable_id: self.id, backable_type: "Team", paid: true).where('created_at >= ?', 1.hour.ago).count != 0
      self.update_raised
    # end
  end

  after_save do
    self.update_raised
  end

  def total_raised
  # self.contributions.where(paid: true).pluck(:amount).sum +
     self.attendees.where(paid: true).pluck(:raised).sum
  end

  def update_raised
    self.update_column(:raised, total_raised)
  end

  paginates_per 6

  def raised_percent
    if raised != 0
      (self.total_raised / self.goal) * 100
    else
      0
    end
  end
end
