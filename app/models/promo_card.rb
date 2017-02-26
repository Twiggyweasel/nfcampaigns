class PromoCard < ApplicationRecord
  belongs_to :event
  belongs_to :promotion
  mount_uploader :background_image, ChampionImageUploader
  mount_uploader :image, ChampionImageUploader
end
