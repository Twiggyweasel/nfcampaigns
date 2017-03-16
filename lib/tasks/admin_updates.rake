desc "This task sends admins all new users"
task :send_new_users => :environment do
  puts "building new user summary"
  User.admins.each do |user|
    AdminMailer.new_users(user).deliver_later
  end
  puts "done."
end
