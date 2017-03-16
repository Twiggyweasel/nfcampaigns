desc "This task sends admins all new users"
task :send_new_users => :environment do
  puts "building new user summary"
  User.admins.each do |admin|
    AdminMailer.new_users(admin)
  end
  puts "done."
end
