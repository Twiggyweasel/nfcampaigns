desc "This task sends admins all new users"
task :send_new_users => :environment do
  puts "building new user summary"
  User.admins.each do |user|
    AdminMailer.new_users(user, User.is_new).deliver
  end
  puts "done."
end

task :send_new_actions => :environment do
  puts "building new actions summary"
  if User.is_new_1_hours.any? ||  Attendee.is_new_1_hours.any? || Payment.is_new_1_hours.any?
    User.admins.each do |user|
      AdminMailer.new_actions(user, User.is_new_1_hours, Attendee.is_new_1_hours, Payment.is_new_1_hours).deliver
    end
  end
  puts "done."
end

task :order_clean_up => :environment do
  puts "Cleaning up pending Orders"
  if Order.expiring.any?
    Order.expiring.each do |order|
      order.destroy
    end
  end
  puts "Order cleanup complete"
end

task :contribution_email_resend => :environment do
  puts "starting email list"
  if Payment.is_paid_contribution.any?
    Payment.is_paid_contribution.each do |pay|
      PaymentsMailer.contribution_payment(pay).deliver
    end
  end
  puts "ending email list"
end