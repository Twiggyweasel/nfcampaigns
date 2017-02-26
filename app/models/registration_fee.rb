class RegistrationFee < ApplicationRecord
  belongs_to :event
  
  validates :name, presence: true 
  validates :category, presence: true
  validates :amount, presence: true
  
  scope :is_corporate, -> { where(category: 'Corporate') }
  scope :is_personal, -> { where(category: 'Personal') }
  scope :is_fundraise, -> { where(category: 'Fundraising')}
  
  def name_w_description
    "#{name} $#{amount.round()} - #{description}"
  end
end