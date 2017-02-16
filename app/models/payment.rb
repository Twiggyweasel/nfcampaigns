class Payment < ApplicationRecord
  require "active_merchant/billing/rails"
  belongs_to :payable, polymorphic: true
  attr_accessor :card_security_code
  attr_accessor :credit_card_number
  attr_accessor :expiration_month
  attr_accessor :expiration_year

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :card_security_code, presence: true
  validates :credit_card_number, presence: true
  validates :expiration_month, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
  validates :expiration_year, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }

  validate :valid_card
  
  def finalize
    if self.success == true 
      self.payable.update_column(:paid, true)
      self.update_column(:confirmation_number, (0...4).map { (65 + rand(20)) }.join)
    end
  end

  def credit_card
    ActiveMerchant::Billing::CreditCard.new(
      number:              credit_card_number,
      verification_value:  card_security_code,
      month:               expiration_month,
      year:                expiration_year,
      first_name:          first_name,
      last_name:           last_name
    )
  end

  def valid_card
    if !credit_card.valid?
      errors.add(:base, "The credit card information you provided is not valid.  Please double check the information you provided and then try again.")
      false
    else
      true
    end
  end

  def process
    if valid_card
      response = GATEWAY.authorize((amount * 100).floor, credit_card)
      if response.success?
        transaction = GATEWAY.capture((amount * 100).floor, response.authorization)
        if !transaction.success?
          update_columns({last4: credit_card.number[-4..-1], success: false})
          # errors.add(:base, "Error: credit card is not valid. #{credit_card.errors.full_messages.join('. ')}")
          errors.add(:base, "The credit card you provided was declined.  Please double check your information and try again.") and return
          false
        end
        update_columns({authorization_code: transaction.authorization, success: true, last4: credit_card.number[-4..-1]})
        true
      else
        update_columns({last4: credit_card.number[-4..-1]})
        errors.add(:base, "Error: credit card is not valid. #{credit_card.errors.full_messages.join('. ')}")
        errors.add(:base, "The credit card you provided could not be authorized.  Please double check your information and try again.") and return
        false
      end
    end
  end
  
  def fee(amount)
    (amount * 0.029) + 0.30  
  end
end
