desc "This task sends admins all new users"
task :send_new_users => :environment do
  puts "building new user summary"
  User.admins.offset(1).each do |user|
    AdminMailer.new_users(user, @user.is_new).deliver
  end
  puts "done."
end
