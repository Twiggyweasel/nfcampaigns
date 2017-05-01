class Champion < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :event
  has_many :contributions, as: :backable

  mount_uploader :champion_image, ChampionImageUploader

  def update_raised
    return
  end
end