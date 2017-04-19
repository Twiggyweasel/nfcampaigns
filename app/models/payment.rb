class Payment < ApplicationRecord
  require "active_merchant/billing/rails"
  belongs_to :payable, polymorphic: true
  attr_accessor :card_security_code
  attr_accessor :credit_card_number
  attr_accessor :expiration_month
  attr_accessor :expiration_year
  attr_accessor :street
  attr_accessor :apt
  attr_accessor :city
  attr_accessor :state
  attr_accessor :zip
  attr_accessor :fee

  validates :first_name, presence: true, :on => :create
  validates :last_name, presence: true, :on => :create
  validates :card_security_code, presence: true, :on => :create
  validates :credit_card_number, presence: true, :on => :create
  validates :expiration_month, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }, :on => :create
  validates :expiration_year, presence: true, :on => :create
  validates :amount, presence: true, numericality: { greater_than: 0 }, :on => :create

  validates :street, presence: true, :on => :create

  validates :city, presence: true, :on => :create
  validates :state, presence: true, :on => :create
  validates :zip, presence: true, length: { is: 5 }, :on => :create
  validates :zip, presence: true, :on => :create
  validate :valid_card, :on => :create

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, :presence   => true,
            :format     => { :with => email_regex },
            :uniqueness => { :case_sensitive => false }, :on => :create

  scope :is_new_1_hours, -> { where(created_at: (Time.now - 1.hours)..Time.now) }

  def finalize
    if self.success == true
      self.payable.update_column(:paid, true)
      if self.payable.is_a? Attendee
        self.payable.guests.update_all(paid: true)
      end
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

  def purchase_options
    {
      :billing_address => {
        :address1 => street,
        :address2 => apt,
        :city => city,
        :state => state,
        :zip => zip

      }
    }
  end

  def final_amount
    fee_amount = fee(self.amount)

    if !self.promo_code.empty?
    promo = (Promotion.where(code: self.promo_code).first.discount / 100)
    promo_reduction = (self.amount * promo)
    end

    if self.cover_processing
      if self.promo_code.empty?
        (self.amount + fee_amount)
      else
        ((self.amount - promo_reduction) + fee_amount)
      end
    else
      if self.promo_code.empty?
        self.amount
      else
        (self.amount - promo_reduction)
      end
      end
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
      response = GATEWAY.authorize((final_amount * 100), credit_card, purchase_options)
      if response.success?
        transaction = GATEWAY.capture((final_amount * 100).floor, response.authorization)
        if !transaction.success?
          update_columns({ last4: credit_card.number[-4..-1], success: false, amount: (final_amount.floor2(2)), authorization_code: StandardError.new( response.message ).to_s})
          # errors.add(:base, "Error: credit card is not valid. #{credit_card.errors.full_messages.join('. ')}")
          errors.add(:base, "The credit card you provided was declined.  Please double check your information and try again.") and return
          false
        end
        update_columns({ authorization_code: transaction.authorization, success: true, last4: credit_card.number[-4..-1], amount: (final_amount.floor2(2)) })
        true
      else
        update_columns({last4: credit_card.number[-4..-1], success: false, amount: (final_amount).floor2(2), authorization_code: StandardError.new( response.message ).to_s})
        errors.add(:base, "The credit card you provided could not be authorized.  Please double check your information and try again.") and return
        false
      end
    end
  end

  def fee(amount)
    (amount * 0.029) + 0.30
  end

  def fullname
    self.first_name + " " + self.last_name
  end

  def set_email
    if !self.payable.user.nil? and self.email.nil?
      self.update_column(:email, self.payable.user.email)
    end
  end

end

class BigDecimal
  def ceil2(exp = 0)
   multiplier = 10 ** exp
   ((self * multiplier).ceil).to_f/multiplier.to_f
  end
end

class BigDecimal
  def floor2(exp = 0)
   multiplier = 10 ** exp
   ((self * multiplier).floor).to_f/multiplier.to_f
  end
end

class Float
  def ceil2(exp = 0)
   multiplier = 10 ** exp
   ((self * multiplier).ceil).to_f/multiplier.to_f
  end
end

class Float
  def floor2(exp = 0)
   multiplier = 10 ** exp
   ((self * multiplier).floor).to_f/multiplier.to_f
  end
end
