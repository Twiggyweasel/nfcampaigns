#User class is responsible for creating user records 
class User < OmniAuth::Identity::Models::ActiveRecord
  belongs_to :role
  has_one :profile, :dependent => :destroy
  has_many :team_leaders
  has_many :attendees
  has_many :guests, through: :attendees
  has_many :events, through: :attendees
  has_many :teams, through: :attendees
  has_many :pledge_pages, through: :attendees
  has_many :contributions
  has_many :champions
  
  has_many :authentications, dependent: :destroy
  
  scope :admins, -> { where(role_id: 1) } 
  mount_uploader :profile_pic, ChampionImageUploader
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, :presence   => true,
            :format     => { :with => email_regex },
            :uniqueness => { :case_sensitive => false }

  
  scope :is_new, -> { where(created_at: (Time.now - 24.hours)..Time.now) }
  
  def self.create_with_omniauth(auth)
    pass_gen = rand(36**10).to_s(36)
    auth_name = auth['info']['name']
    auth_email = auth['info']['email']

    case auth['provider']
    when 'facebook'
      create(name: auth_name, password: pass_gen, email: auth_email, remote_profile_pic_url: auth['info']['image'], role_id: 2)
    when 'google_oauth2'
      create(name: auth_name, password: pass_gen, email: auth_email, remote_profile_pic_url: auth['info']['image'], role_id: 2)
    when 'twitter'
      create(name: auth_name, password: pass_gen, remote_profile_pic_url: auth['info']['image'], role_id: 2)
    else
      create(name: auth_name, email: auth_email, password: auth['info']['password'], role_id: 2)
    end

  end
  
  def total_raised
    if self.attendees.where(paid: true).pluck(:raised).blank? && self.contributions.where(paid: true).pluck(:amount).blank?
      0
    else  
      self.attendees.where(paid: true).pluck(:raised).sum + self.contributions.where(paid: true).pluck(:amount).sum
    end
  end
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver_later
  end
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  paginates_per 6
  
end