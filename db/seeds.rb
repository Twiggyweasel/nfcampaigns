# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'


Role.create! name: 'admin'
Role.create! name: 'user'

Size.create! label: "Y X-Small"
Size.create! label: 'Y Small'
Size.create! label: 'Y Medium'
Size.create! label: 'Y Large'
Size.create! label: 'Y XL'
Size.create! label: 'Y XXL'
Size.create! label: 'A Small'
Size.create! label: 'A Medium'
Size.create! label: 'A Large'
Size.create! label: 'A XL'
Size.create! label: 'A XXL'
Size.create! label: 'A XXXL'

User.create! name: 'Master User', email: "admin@nfcampaigns.org", password: "test_123", role_id: 1

if Rails.env == "development"

  Event.create! name: 'Event One', event_type: 'Walk', desc: 'Test is a test', teaser: "Teaser Text", registration_date: '2017-01-08', event_date: '2017-3-08', event_start_time: "2000-01-01 8:30:00", goal: 10000, raised: 0, venue_name: 'Magic Fields Park', street: '13308 W 96th Terr', city: 'Lenexa', state: 'KS', zipcode: '66215', has_shirts: true, is_private: true, size_ids: [1,2,3,4,5]
  Event.create! name: 'Event Two', event_type: 'Walk', desc: 'Test is a test', teaser: "Teaser Text", registration_date: '2017-01-08', event_date: '2017-5-16', event_start_time: "2000-01-01 19:30:00", goal: 40000, raised: 0, venue_name: 'Magic Fields Park', street: '13308 W 96th Terr', city: 'Lenexa', state: 'KS', zipcode: '66215', has_shirts: true, is_private: false, size_ids: [1,2,3,4,5]
  

  
  25.times do
    User.create( 
      name: Faker::Name.unique.name,
      email: Faker::Internet.unique.email,
      password: "test_123",
      role_id: 2
    )
  end
  
  count = 1
  25.times do 
  
    user = User.find(count)
    
    user.create_profile(
      street: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state_abbr,
      zipcode: Faker::Address.zip,
      has_nf: true,
      child_with_nf: false,
      news_letter: true,
      event_notifications: true
    )
    
    count += 1
  end
  
  10.times do 
    Team.create(
      name: Faker::Address.unique.city + " Team",
      max_members: 999,
      goal: 10000,
      event_id: rand(1..2),
    )
  end
  
  
  
  
  
  55.times do
    Attendee.create(
      fee: 25.00,
      shirt_size: 'medium',
      event_id: rand(1..2),
      team_id: rand(3..12),
      user_id: rand(2..25)
    )
    
  end
  
  teamcount = 3
  10.times do 
    attendee = Team.find(teamcount).attendees.first 
  
    attendee.update(is_leader: true)
  
    teamcount += 1
  end
  # for i in 0..Team.count
  #   team = Team.find(i) 
  #   if team.attendees.count != 0
  #     team.attendees.first.update(is_leader: "true")
  #   end
  # end
  
  100.times do
    Contribution.create(
      amount: rand(1..550),
      backable: Event.find(rand(1..2)),
      user_id: rand(2..26),
    )
  end
  
  100.times do
    Contribution.create(
      amount: rand(1..550),
      backable: Attendee.find(rand(1..15)),
      user_id: rand(2..26),
    )
  end
  
  100.times do
    Contribution.create(
      amount: rand(1..550),
      backable: Team.find(rand(3..12)),
      user_id: rand(2..26),
    )
  end
  
  
  RegistrationFee.create! name: "Adult", amount: 25.00, event_id: 1
  RegistrationFee.create! name: "Child Under 13", amount: 15.00, event_id: 1
  RegistrationFee.create! name: "Child Under 3", amount: 0.00, event_id: 1
  
  RegistrationFee.create! name: "Adult", amount: 25.00, event_id: 2
  RegistrationFee.create! name: "Child Under 13", amount: 15.00, event_id: 2
  RegistrationFee.create! name: "Child Under 3", amount: 0.00, event_id: 2
  
  Promotion.create! name: "$20 Discount", desc: "grants $20 discount to entire cart", code: "NF20OFF", is_active: true 

end 