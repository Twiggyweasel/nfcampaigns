class Resource < ApplicationRecord
  belongs_to :event
  mount_uploader :attachment, AttachmentUploader
  
  validates :name, presence: true
  validates :attachment, presence: true 
  
end