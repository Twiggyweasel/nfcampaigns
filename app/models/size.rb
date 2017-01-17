class Size < ApplicationRecord
  has_many :events
  has_many :event_sizes
end