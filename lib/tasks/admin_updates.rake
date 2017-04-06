desc "This task sends admins all new users"
task :send_new_users => :environment do
  puts "building new user summary"
  User.admins.offset(1).each do |user|
    AdminMailer.new_users(user, User.is_new).deliver
  end
  puts "done."
end

task :send_new_actions => :environment do
  puts "building new actions summary"
  if User.is_new_1_hours.any? ||  Attendee.is_new_1_hours.any? || Payment.is_new_1_hours.any?
    User.admins.offset(1).each do |user|
      AdminMailer.new_actions(user, User.is_new_1_hours, Attendee.is_new_1_hours, Payment.is_new_1_hours).deliver
    end
  end
  puts "done."
end

