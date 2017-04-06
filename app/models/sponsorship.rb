class Sponsorship < ApplicationRecord
  belongs_to :ticket
  belongs_to :user
  belongs_to :event
  belongs_to :sponsor_level
  has_many :payments, as: :payable
  
  validates :name, presence: true
  mount_uploader :image, GalleryUploader
  
  def amount
    self.fee
  end
end